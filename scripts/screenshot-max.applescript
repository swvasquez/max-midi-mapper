-- screenshot-max.applescript <patch-name> [zoom]
-- Captures a screenshot of a Max patch window and saves it as a PNG.
--
-- Arguments:
--   patch-name  Patch filename without extension (e.g. "midi-transform")
--   zoom        Optional. Integer zoom steps relative to 100%: positive = zoom in (cmd+=),
--               negative = zoom out (cmd+-). Default "auto": computes the minimum zoom-out
--               steps needed to fit all patch content within the window.
--   console     Optional. Pass "toggle" to send cmd+m before capturing (dismisses console).
--
-- Behavior:
--   - Opens the patch in Max if not already open, or brings it to front if it is.
--   - Computes a tight window size from the patch object bounds (patching_rect values in
--     the .maxpat JSON correspond to actual pixels at 100% zoom).
--   - If content fits on screen at 100%, sizes the window tightly around content.
--   - If content is too large, uses full screen and zooms out until it fits.
--   - Resets to 100% zoom (cmd+0) before applying any zoom steps.
--   - Captures the window using screencapture, then resizes the PNG with sips so the
--     longest dimension is strictly less than 2000px (for compatibility with tools like Zed).
--   - Restores focus to the previously active application when done.
--
-- Usage:
--   osascript screenshot-max.applescript midi-transform
--   osascript screenshot-max.applescript midi-transform -2
--   osascript screenshot-max.applescript midi-transform 1

on run argv
    if (count of argv) < 1 then error "Usage: osascript screenshot-max.applescript <patch-name> [zoom]"
    set patchName to item 1 of argv
    -- "auto" = compute zoom steps from content bounds; any integer overrides
    set manualZoom to "auto"
    if (count of argv) >= 2 then set manualZoom to item 2 of argv
    set toggleConsole to false
    if (count of argv) >= 3 and item 3 of argv is "toggle" then set toggleConsole to true

    set currentDir to do shell script "pwd"
    set patchPath to currentDir & "/" & patchName & ".maxpat"
    set savePath to currentDir & "/" & patchName & ".png"
    set previousApp to path to frontmost application as text

    -- Open the patch if not already open; if already open, `open` just brings it to front
    do shell script "open -a Max " & quoted form of patchPath
    delay 1.0

    -- Unminimize and raise the patch window if needed
    tell application "System Events"
        tell process "Max"
            repeat with win in every window
                try
                    if name of win contains patchName then
                        if value of attribute "AXMinimized" of win is true then
                            set value of attribute "AXMinimized" of win to false
                        end if
                        perform action "AXRaise" of win
                    end if
                end try
            end repeat
        end tell
    end tell
    tell application "Max" to activate
    delay 0.5

    if toggleConsole then
        tell application "System Events"
            tell process "Max"
                keystroke "m" using command down
            end tell
        end tell
        delay 1.5
    end if

    -- Parse the .maxpat JSON to compute content bounds and ideal window/zoom settings.
    -- patching_rect is [x, y, width, height] in pixels at 100% zoom.
    -- zoom_levels are Max's discrete zoom steps when pressing cmd+- from 100%.
    -- If content fits at 100%, size the window tightly around it.
    -- If content is too large for the screen, use full screen and zoom out to fit.
    set boundsResult to do shell script "python3 -c \"\
import json
with open('" & patchPath & "') as f:
    p = json.load(f)['patcher']
boxes = p['boxes']
max_x = max(b['box']['patching_rect'][0] + b['box']['patching_rect'][2] for b in boxes)
max_y = max(b['box']['patching_rect'][1] + b['box']['patching_rect'][3] for b in boxes)
pad_x, pad_y = 80, 120   # padding for Max sidebars and toolbar
margin = 10              # extra visible margin around patch content
screen_w, screen_h = 1800, 1100  # max window size (fits most screens)
zoom_levels = [1.0, 0.75, 0.66, 0.50, 0.33, 0.25]  # Max cmd+- steps from 100%
vp_w = screen_w - 80   # usable viewport width (subtract sidebars)
vp_h = screen_h - 105  # usable viewport height (subtract toolbar + bottom bar)
steps = 0
for i, z in enumerate(zoom_levels):
    if max_x * z <= vp_w and max_y * z <= vp_h:
        steps = -i
        break
if steps == 0:
    win_w = int(max_x + pad_x + 2 * margin)
    win_h = int(max_y + pad_y + 2 * margin)
else:
    win_w, win_h = screen_w, screen_h
print(win_w, win_h, steps)
\""
    set winW to (word 1 of boundsResult) as integer
    set winH to (word 2 of boundsResult) as integer
    set autoZoom to (word 3 of boundsResult) as integer

    -- Use auto-computed zoom unless caller passed an explicit value
    set zoomSteps to autoZoom
    if manualZoom is not "auto" then set zoomSteps to manualZoom as integer

    -- Resize the window to the computed dimensions
    tell application "System Events"
        tell process "Max"
            set winList to every window
            repeat with win in winList
                try
                    if name of win contains patchName then
                        set size of win to {winW, winH}
                        set position of win to {0, 25}
                        delay 0.3
                    end if
                end try
            end repeat
        end tell
    end tell

    -- Reset to 100% zoom (cmd+0), then apply zoom steps.
    -- Positive steps zoom in (cmd+=), negative zoom out (cmd+-).
    tell application "System Events"
        tell process "Max"
            keystroke "0" using command down
            delay 0.2
            if zoomSteps > 0 then
                repeat zoomSteps times
                    keystroke "=" using command down
                    delay 0.1
                end repeat
            else if zoomSteps < 0 then
                repeat (-zoomSteps) times
                    keystroke "-" using command down
                    delay 0.1
                end repeat
            end if
            delay 0.2
        end tell
    end tell

    -- Use Swift + CoreGraphics to get the exact window bounds (x, y, width, height)
    -- This works even across Spaces and handles Retina scaling correctly.
    set winRect to do shell script "swift - <<'SWIFT'
import CoreGraphics
import Foundation
let target = \"" & patchName & "\"
if let windows = CGWindowListCopyWindowInfo([.optionAll], kCGNullWindowID) as? [[String: Any]] {
    for w in windows {
        if let owner = w[\"kCGWindowOwnerName\"] as? String, owner == \"Max\",
           let name = w[\"kCGWindowName\"] as? String, name.contains(target),
           let b = w[\"kCGWindowBounds\"] as? [String: Any],
           let x = b[\"X\"] as? Int, let y = b[\"Y\"] as? Int,
           let w = b[\"Width\"] as? Int, let h = b[\"Height\"] as? Int {
            print(\"\\(x),\\(y),\\(w),\\(h)\")
            break
        }
    }
}
SWIFT"

    if winRect is "" then error "Could not find " & patchName & " window in Max"

    -- Capture the window region to PNG
    do shell script "screencapture -R " & winRect & " " & quoted form of savePath

    -- Resize PNG so longest dimension is strictly less than 2000px (only if needed).
    -- Keeps file size manageable for tools like Zed that have image size limits.
    do shell script "sips --resampleHeightWidthMax 1999 " & quoted form of savePath & " > /dev/null"

    tell application previousApp to activate
    return "Saved to " & savePath
end run
