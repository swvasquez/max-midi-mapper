// cc-quantize.js — quantize CC values to a discrete set
//
// Divides the 0–127 range evenly into one bucket per target value.
// Each incoming CC is mapped to whichever bucket it falls into.
//
// Example with values 0|32|64|96|127 (5 buckets, each ~25.6 wide):
//   0–25   → 0
//   26–51  → 32
//   52–76  → 64
//   77–101 → 96
//   102–127 → 127
//
// Options:
//   values   pipe-separated target CC values  (default: "0|64|127")
//            e.g. params: values 0|32|64|96|127
//   cn       controller number to filter on; if set, only that controller is quantized (default: unset)
//
// Note: commas and spaces are Max message separators and cannot be used here.
//
// Note events are passed through unchanged.

module.exports = function run(pitch, velocity, options, cc, noteHistory, ccHistory) {
    return [pitch, velocity];
};

module.exports.runCC = function(controller, value, options, cc, noteHistory, ccHistory) {
    if (options && options.cn !== undefined && parseInt(options.cn, 10) !== controller) return [controller, value];
    var raw = (options && options.values) ? String(options.values) : "0|64|127";
    var parts = raw.split("|");
    var values = [];
    for (var i = 0; i < parts.length; i++) {
        var n = parseInt(parts[i], 10);
        if (!isNaN(n)) values.push(n);
    }
    if (values.length === 0) return [controller, value];
    var index = Math.min(Math.floor(value * values.length / 128), values.length - 1);
    return [controller, values[index]];
};

module.exports.defaults = { values: "0|64|127" };
