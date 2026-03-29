// identity.js — pass MIDI through unchanged
//
// Options: none
//
// pitch      0–127  MIDI note number, returned as-is
// velocity   0–127  note velocity, returned as-is
// cc         object  current CC state, not used
module.exports = function run(pitch, velocity, options, cc) {
    return [pitch, velocity];
};

module.exports.runCC = function(controller, value, options, cc) {
    return [controller, value];
};
