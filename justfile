# screenshot — capture a Max patch window to a PNG
#
# Arguments:
#   patch    Patch name without extension (default: midi-transform)
#   zoom     Zoom steps from 100%: positive = zoom in, negative = zoom out.
#            Default "auto": automatically computes the minimum zoom-out needed
#            to fit all patch content. Override with an integer to force a level.
#   console  Pass "toggle" to send cmd+m before capturing (dismisses the console).
#
# Examples:
#   just screenshot                             # auto zoom, default patch
#   just screenshot midi-transform              # auto zoom, named patch
#   just screenshot midi-transform -2           # force 2 zoom-out steps
#   just screenshot midi-transform auto toggle  # dismiss console first

screenshot patch="midi-transform" zoom="auto" console="":
    osascript scripts/screenshot-max.applescript {{patch}} {{zoom}} {{console}}
