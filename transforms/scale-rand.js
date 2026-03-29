// scale-rand.js — replace each note with a random pitch from a named scale
//
// Builds all MIDI pitches (0–127) whose pitch class belongs to the specified
// scale, then picks one at random from the exclusive range
// (n-(r+1)*12, n+(r+1)*12) where n is the input pitch and r is `range`.
//
// Options:
//   scale        string  scale name from the SCALES dict below  (default: "major")
//   root         string  root note, case-insensitive, e.g. C  Bb  F#  Ab  (default: "C")
//   range        int>=0  notes drawn from (n-(r+1)*12, n+(r+1)*12) exclusive (default: 1)
//   p            0–1     probability that the note is replaced at all  (default: 0)
//
// pitch    0–127  MIDI note number
// velocity 0–127  note velocity, passed through unchanged

var scalesModule = require("./transforms/scales.js");
var SCALES = scalesModule.SCALES;
var ALIASES = scalesModule.ALIASES;

var _cache = {};

var NOTE_PCS = { C: 0, D: 2, E: 4, F: 5, G: 7, A: 9, B: 11 };

function parseRoot(str) {
    var s = (str || "C").toUpperCase();
    var pc = NOTE_PCS[s[0]];
    if (pc === undefined) {
        post("scale-rand: unknown root '" + s[0] + "', defaulting to C\n");
        pc = 0;
    }
    var acc = s[1];
    if (acc === "B") pc = (pc - 1 + 12) % 12;
    else if (acc === "S" || acc === "#") pc = (pc + 1) % 12;
    return pc;
}

function buildScalePitches(intervals, root) {
    var pitchClasses = {};
    var pc = root % 12;
    pitchClasses[pc] = true;
    for (var i = 0; i < intervals.length; i++) {
        pc = (pc + intervals[i]) % 12;
        pitchClasses[pc] = true;
    }
    var pitches = [];
    for (var p = 0; p <= 127; p++) {
        if (pitchClasses[p % 12]) pitches.push(p);
    }
    return pitches;
}

module.exports = function run(pitch, velocity, options, cc, noteHistory, ccHistory) {
    var scaleName = (options && options.scale) ? options.scale : "major";
    var rootStr = (options && options.root) ? options.root : "C";
    var range = (options && options.range !== undefined) ? options.range : 1;
    var p = (options && options.p !== undefined) ? options.p : 0.5;
    if (Math.random() >= p) return [pitch, velocity];
    var cacheKey = rootStr + ":" + scaleName;
    if (!_cache[cacheKey]) {
        var resolved = ALIASES[scaleName] || scaleName;
        var intervals = SCALES[resolved];
        if (!intervals) {
            post("scale-rand: unknown scale '" + resolved + "', passing through\n");
            return [pitch, velocity];
        }
        _cache[cacheKey] = buildScalePitches(intervals, parseRoot(rootStr));
    }
    var allPitches = _cache[cacheKey];
    var lo = pitch - (range + 1) * 12;
    var hi = pitch + (range + 1) * 12;
    var pitches = [];
    for (var i = 0; i < allPitches.length; i++) {
        var candidate = allPitches[i];
        if (candidate > lo && candidate < hi && candidate !== pitch) pitches.push(candidate);
    }
    if (pitches.length === 0) return [pitch, velocity];
    var newPitch = pitches[Math.floor(Math.random() * pitches.length)];
    return [newPitch, velocity];
};

module.exports.runCC = function(controller, value, options, cc, noteHistory, ccHistory) {
    return [controller, value];
};

module.exports.defaults = { root: "C", scale: "major", range: 1, p: 0.5 };
