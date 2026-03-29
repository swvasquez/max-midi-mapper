# max-midi-mapper

## About

A Max 9 patch for transforming MIDI notes in real time using swappable JavaScript transform functions. 

The below visualization of the patch shows custom MIDI logic for electronic instruments -- arbitrary pitch and CC transformations written in JavaScript -- living between the MIDI source and the instrument.

<img src="midi-transform.png" width="500" />

> This code has been developed with AI assistance.

## How it works

Notes and CCs flow through the patch in parallel. Notes: `notein` → JS transform → `noteout`. CCs: `ctlin` → JS transform → `ctlout`. The active transform is a JS module that receives `(pitch, velocity, options, cc)` and returns `[pitch, velocity]`. CCs are stored in the `cc` object (keyed by controller number) and passed as context to every note event. Transforms are hot-swappable from the patch UI without interrupting the signal chain.

## Configuration

| Parameter | Description |
|-----------|-------------|
| **debug** | Log each note transform to the Max console |
| **in ch** | MIDI input channel (0 = all) |
| **out ch** | MIDI output channel |
| **transform** | Active transform (selected from `transforms/`) |
| **params** | Key-value pairs passed as options to the active transform (e.g. `root Bb scale minor p 0.5`) |

## Transforms

Transform files live in `transforms/`. Each exports a note handler, and optionally a CC handler:

```js
// Required: handle note events
// cc is a live snapshot of all received CC values: { controller: value, ... }
module.exports = function run(pitch, velocity, options, cc) {
    return [pitch, velocity];
};

// Optional: handle CC events. Defaults to pass-through if not defined.
module.exports.runCC = function(controller, value, options, cc) {
    return [controller, value];
};
```

| File | Description |
|------|-------------|
| `identity.js` | Pass MIDI through unchanged |
| `octave-rand.js` | Randomly shift pitch by ±N octaves. Option: `range <n>` |
| `scale-rand.js` | Randomly replace notes with pitches from a named scale. Options: `root <note>`, `scale <name>`, `range <n>`, `p <0-1>` |
| `cc-quantize.js` | Quantize CC values to a discrete set. Divides 0–127 into equal buckets, one per value. Option: `values <pipe-separated>` (e.g. `values 0|32|64|96|127`) |

Scale names and aliases are defined in `transforms/scales.js`.

> **Note:** "scale" in this repo refers to a rootless interval pattern (e.g. `major` = `[2,2,1,2,2,2,1]`). The root is supplied separately via the `root` option and combined at runtime to produce actual pitches.

To add a new transform, create `transforms/my-transform.js` and add it to the umenu in the patch.

## Development

This project uses [Zed](https://zed.dev) as the editor alongside an AppleScript-based screenshot tool that captures the Max patch window for review. This is particularly useful when working with AI assistance on layout and wiring — you can take a snapshot and share it directly as context.

```sh
# Capture a screenshot of the patch (no extension)
just screenshot midi-transform
```

## Notes

- **JavaScript compatibility**: Max v8 uses a non-standard JS engine — transform scripts must use ES5-style code (`var`, `function`, no arrow functions, no template literals, no destructuring, etc.).
- **Screenshot size**: The screenshot script resizes the output image so the longest dimension is strictly less than 2000px — the image size limit for Zed AI conversations.
- **AppleScript brittleness**: `scripts/screenshot-max.applescript` relies on macOS Accessibility APIs and screen capture permissions. It may require Accessibility and Screen Recording permissions to be granted in System Settings, and may need modification depending on your screen resolution, Max window layout, or OS version.
