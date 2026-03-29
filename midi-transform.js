// midi-transform.js — Max v8 MIDI transform loader
//
// INLET 0 accepts four message types:
//
//   list <pitch> <velocity> <channel>
//     Received from notein via [pack 0 0 0]. Runs the active transform on
//     note-on events and routes note-off to the correct (transformed) pitch.
//     Filtered by in_ch option: channel 0 = pass all, 1–16 = specific channel.
//
//   cc <controller> <value> <channel>
//     Received from ctlin via [pack 0 0 0] + [prepend cc]. Updates ccState and
//     runs transformFn.runCC if defined; otherwise passes through unchanged.
//     Filtered by in_ch the same way as notes.
//
//   transform <name>
//     Load a new transform from transforms/<name>.js. Resets options and
//     clears the active note map. Example: "transform octave-rand"
//
//   option <key> <value>
//     Set a named option on the active transform. Built-in keys:
//       in_ch   — MIDI channel to accept (0 = all, 1–16 = specific)
//     Transforms may define their own keys (e.g. "option neighborhood 2").
//
// OUTLET 0 emits: <pitch> <velocity>
//   note-on:  transformed pitch and velocity
//   note-off: same pitch that was used for the corresponding note-on
//
// OUTLET 1 emits: <controller> <value>
//   CC output from transformFn.runCC, or pass-through if not defined

inlets = 1;
outlets = 2;

var transformFn = null;
var transformDefaults = {};
var options = {};
var noteMap = {};   // maps input pitch -> output pitch for active notes
var ccState = {};   // maps controller number -> most recent value

function postOptions() {
    var keys = [];
    for (var k in transformDefaults) {
        var val = (options[k] !== undefined) ? options[k] : transformDefaults[k];
        var suffix = (options[k] !== undefined) ? "" : " (default)";
        keys.push(k + "=" + val + suffix);
    }
    for (var k in options) {
        if (k === "in_ch" || k === "debug") continue;
        if (transformDefaults[k] === undefined) keys.push(k + "=" + options[k]);
    }
    post("options: " + (keys.length ? keys.join(", ") : "(none)") + "\n");
}

function fmtNote(p, v) {
    var ps = String(p); while (ps.length < 3) ps = "0" + ps;
    var vs = String(v); while (vs.length < 3) vs = "0" + vs;
    return "[" + ps + "," + vs + "]";
}

loadTransform("identity");

function loadTransform(name) {
    try {
        transformFn = require("./transforms/" + name + ".js");
        transformDefaults = transformFn.defaults || {};
        options = { in_ch: options.in_ch, debug: options.debug };
        noteMap = {};
        post("midi-transform: loaded '" + name + "'\n");
    } catch (e) {
        post("midi-transform: failed to load '" + name + "': " + e + "\n");
    }
}

function transform(name) {
    loadTransform(name);
}

function option(key, value) {
    options[key] = value;
    if (options.debug && key !== "debug") postOptions();
}

// textedit outlet 0 sends a "text" selector, making arg[0] the literal string "text".
// Skip it so key-value parsing starts at the actual content.
function setoptions() {
    var in_ch = options.in_ch;
    var debug = options.debug;
    for (var k in options) { delete options[k]; }
    if (in_ch !== undefined) options.in_ch = in_ch;
    if (debug !== undefined) options.debug = debug;
    var start = (arguments[0] === "text") ? 1 : 0;
    for (var i = start; i < arguments.length - 1; i += 2) {
        options[String(arguments[i])] = arguments[i + 1];
    }
    if (options.debug) postOptions();
}

function list(pitch, velocity, channel) {
    if (!transformFn) return;
    var in_ch = options.in_ch || 0;
    if (in_ch !== 0 && channel !== in_ch) return;

    var outP, outV;
    if (velocity === 0) {
        // Note-off: use the pitch from note-on time so release matches even if transform is non-deterministic.
        outP = (noteMap[pitch] !== undefined) ? noteMap[pitch] : pitch;
        outV = 0;
        delete noteMap[pitch];
    } else {
        var out = transformFn(pitch, velocity, options, ccState);
        noteMap[pitch] = out[0];
        outP = out[0];
        outV = out[1];
    }
    if (options.debug) post(fmtNote(pitch, velocity) + " -> " + fmtNote(outP, outV) + "\n");
    outlet(0, outP, outV);
}

function cc(controller, value, channel) {
    if (!transformFn) return;
    var in_ch = options.in_ch || 0;
    if (in_ch !== 0 && channel !== in_ch) return;

    ccState[controller] = value;

    var outC, outV;
    if (transformFn.runCC) {
        var out = transformFn.runCC(controller, value, options, ccState);
        outC = out[0];
        outV = out[1];
    } else {
        outC = controller;
        outV = value;
    }
    if (options.debug && (outC !== controller || outV !== value)) post("cc[" + controller + "," + value + "] -> cc[" + outC + "," + outV + "]\n");
    outlet(1, outC, outV);
}
