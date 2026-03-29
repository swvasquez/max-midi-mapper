# screenshot — capture a Max patch window to a PNG
#
# Arguments:
#   patch    Patch name without extension (default: midi-transform)
#   zoom     Zoom steps from 100%: positive = zoom in, negative = zoom out.
#            Default "auto": automatically computes the minimum zoom-out needed
#            to fit all patch content. Override with an integer to force a level.
#   flags    Optional flags: "toggle" dismisses the console, "noresize" skips window resizing.
#
# Examples:
#   just screenshot                                       # auto zoom, default patch
#   just screenshot midi-transform                        # auto zoom, named patch
#   just screenshot midi-transform -2                     # force 2 zoom-out steps
#   just screenshot midi-transform auto toggle            # dismiss console first
#   just screenshot midi-transform auto noresize          # skip window resize

screenshot patch="midi-transform" zoom="auto" flags="":
    osascript scripts/screenshot-max.applescript {{patch}} {{zoom}} {{flags}}

test transform="":
    npm test {{ if transform != "" { "-- --testPathPattern=" + transform } else { "" } }}

lint file="":
    npx eslint {{ if file != "" { file } else { "midi-transform.js transforms/ tests/" } }}
