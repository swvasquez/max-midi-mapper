// octave-rand.js — randomly shift pitch by a whole number of octaves
//
// On each note-on, picks a random octave offset in the range
// [-range, +range] and transposes the pitch by that many
// octaves (12 semitones each). Result is clamped to 0–127.
//
// Options:
//   range  integer >= 0  max octaves to shift up or down (default: 1)
//          e.g. "option range 2" allows shifts of -2, -1, 0, +1, +2 octaves
//   p      0–1           probability that the note is shifted at all (default: 0.5)
//
// pitch    0–127  MIDI note number
// velocity 0–127  note velocity, passed through unchanged
module.exports = function run(pitch, velocity, options, cc, noteHistory, ccHistory) {
    var range = (options && options.range !== undefined) ? options.range : 1;
    var p = (options && options.p !== undefined) ? options.p : 0.5;
    if (Math.random() >= p) return [pitch, velocity];
    var valid = [];
    for (var i = -range; i <= range; i++) {
        var candidate = pitch + i * 12;
        if (candidate !== pitch && candidate >= 0 && candidate <= 127) valid.push(candidate);
    }
    if (valid.length === 0) return [pitch, velocity];
    var newPitch = valid[Math.floor(Math.random() * valid.length)];
    return [newPitch, velocity];
};

module.exports.runCC = function(controller, value, options, cc, noteHistory, ccHistory) {
    return [controller, value];
};

module.exports.defaults = { range: 1, p: 0.5 };
