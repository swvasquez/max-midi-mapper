module.exports.SCALES = {
  "chromatic": [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],

  "major-ionian": [2, 2, 1, 2, 2, 2, 1],
  "dorian": [2, 1, 2, 2, 2, 1, 2],
  "phrygian": [1, 2, 2, 2, 1, 2, 2],
  "lydian": [2, 2, 2, 1, 2, 2, 1],
  "mixolydian": [2, 2, 1, 2, 2, 1, 2],
  "natural-minor-aeolian": [2, 1, 2, 2, 1, 2, 2],
  "locrian": [1, 2, 2, 1, 2, 2, 2],

  "harmonic-minor": [2, 1, 2, 2, 1, 3, 1],
  "harmonic-major": [2, 2, 1, 2, 1, 3, 1],

  "melodic-minor": [2, 1, 2, 2, 2, 2, 1],
  "dorian-flat-2": [1, 2, 2, 2, 2, 1, 2],
  "lydian-augmented": [2, 2, 2, 2, 1, 2, 1],
  "lydian-dominant": [2, 2, 2, 1, 2, 1, 2],
  "mixolydian-flat-6": [2, 2, 1, 2, 1, 2, 2],
  "locrian-sharp-2": [2, 1, 2, 1, 2, 2, 2],
  "altered-super-locrian": [1, 2, 1, 2, 2, 2, 2],

  "phrygian-dominant": [1, 3, 1, 2, 1, 2, 2],
  "double-harmonic-major": [1, 3, 1, 2, 1, 3, 1],
  "hungarian-minor": [2, 1, 3, 1, 1, 3, 1],
  "hungarian-major": [3, 1, 2, 1, 2, 1, 2],
  "neapolitan-minor": [1, 2, 2, 2, 1, 3, 1],
  "neapolitan-major": [1, 2, 2, 2, 2, 2, 1],
  "persian": [1, 3, 1, 1, 2, 3, 1],
  "ukrainian-dorian": [2, 1, 3, 1, 2, 1, 2],
  "enigmatic": [1, 3, 2, 2, 2, 1, 1],

  "major-pentatonic": [2, 2, 3, 2, 3],
  "minor-pentatonic": [3, 2, 2, 3, 2],
  "blues": [3, 2, 1, 1, 3, 2],
  "hirajoshi": [2, 1, 4, 1, 4],
  "in-japanese": [1, 4, 2, 1, 4],
  "yo": [2, 3, 2, 2, 3],

  "whole-tone": [2, 2, 2, 2, 2, 2],
  "augmented": [3, 1, 3, 1, 3, 1],
  "prometheus": [2, 2, 2, 3, 1, 2],

  "diminished-whole-half": [2, 1, 2, 1, 2, 1, 2, 1],
  "diminished-half-whole": [1, 2, 1, 2, 1, 2, 1, 2],
  "bebop-major": [2, 2, 1, 2, 1, 1, 2, 1],
  "bebop-dominant": [2, 2, 1, 2, 2, 1, 1, 1],
  "bebop-dorian": [2, 1, 1, 1, 2, 2, 1, 2],

};

module.exports.ALIASES = {
  "major": "major-ionian",
  "minor": "natural-minor-aeolian",
  "ionian": "major-ionian",
  "aeolian": "natural-minor-aeolian",
  "harmonic": "harmonic-minor",
  "melodic": "melodic-minor",
  "pentatonic": "major-pentatonic"
};
