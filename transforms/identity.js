// identity.js — pass MIDI through unchanged
//
// Options: none
//
// pitch    0–127  MIDI note number, returned as-is
// velocity 0–127  note velocity, returned as-is
module.exports = function run(pitch, velocity, options) {
    return [pitch, velocity];
};
