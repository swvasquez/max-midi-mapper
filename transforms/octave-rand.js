// octave-rand.js — randomly shift pitch by a whole number of octaves
//
// On each note-on, picks a random octave offset in the range
// [-neighborhood, +neighborhood] and transposes the pitch by that many
// octaves (12 semitones each). Result is clamped to 0–127.
//
// Options:
//   neighborhood  integer >= 0  max octaves to shift up or down (default: 1)
//                 e.g. "option neighborhood 2" allows shifts of -2, -1, 0, +1, +2 octaves
//
// pitch    0–127  MIDI note number
// velocity 0–127  note velocity, passed through unchanged
module.exports = function run(pitch, velocity, options) {
    var neighborhood = (options && options.neighborhood !== undefined) ? options.neighborhood : 1;
    var valid = [];
    for (var i = -neighborhood; i <= neighborhood; i++) {
        var candidate = pitch + i * 12;
        if (candidate >= 0 && candidate <= 127) valid.push(candidate);
    }
    var newPitch = valid[Math.floor(Math.random() * valid.length)];
    return [newPitch, velocity];
};

module.exports.defaults = { neighborhood: 1 };
