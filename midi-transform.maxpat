{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 1,
      "revision": 3,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      34,
      96,
      1135,
      852
    ],
    "boxes": [
      {
        "box": {
          "fontname": "Courier New",
          "fontsize": 11,
          "id": "obj-100",
          "linecount": 75,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            764,
            5,
            217,
            1000
          ],
          "text": "— SCALES —\nchromatic\n\nmajor-ionian\ndorian\nphrygian\nlydian\nmixolydian\nnatural-minor-aeolian\nlocrian\n\nharmonic-minor\nharmonic-major\n\nmelodic-minor\ndorian-flat-2\nlydian-augmented\nlydian-dominant\nmixolydian-flat-6\nlocrian-sharp-2\naltered-super-locrian\n\nphrygian-dominant\ndouble-harmonic-major\nhungarian-minor\nhungarian-major\nneapolitan-minor\nneapolitan-major\npersian\nukrainian-dorian\nenigmatic\n\nmajor-pentatonic\nminor-pentatonic\nblues\nhirajoshi\nin-japanese\nyo\n\nwhole-tone\naugmented\nprometheus\ndiminished-whole-half\ndiminished-half-whole\n\nbebop-major\nbebop-dominant\nbebop-dorian\nbebop-melodic-minor\nbebop-harmonic-minor\n\nmajor-blues\negyptian\nkumoi\npelog\nbalinese\nspanish\n\n— aliases —\nmajor → major-ionian\nminor → natural-minor-aeolian\nionian → major-ionian\naeolian → natural-minor-aeolian\nharmonic → harmonic-minor\nmelodic → melodic-minor\npentatonic → major-pentatonic\nminor-blues → blues\naltered → altered-super-locrian\nsuper-locrian → altered-super-locrian\nlydian-b7 → lydian-dominant\ndiminished → diminished-whole-half\nhalf-whole → diminished-half-whole\nwhole-half → diminished-whole-half\nphrygian-major → phrygian-dominant\nbyzantine → double-harmonic-major"
        }
      },
      {
        "box": {
          "id": "obj-11",
          "linecount": 4,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            473,
            857,
            103,
            60
          ],
          "text": "In Run Mode, click to select output MIDI device "
        }
      },
      {
        "box": {
          "id": "obj-5",
          "linecount": 3,
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            493,
            358,
            105,
            47
          ],
          "text": "In Run Mode, Click to select input MIDI device "
        }
      },
      {
        "box": {
          "fontface": 1,
          "id": "obj-8",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            340,
            117,
            20
          ],
          "text": "— WORKFLOW —"
        }
      },
      {
        "box": {
          "fontface": 1,
          "fontsize": 14,
          "id": "obj-1",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            5,
            498,
            22
          ],
          "text": "MIDI Note & CC Transform — notein & ctlin → v8 JS → noteout & ctlout"
        }
      },
      {
        "box": {
          "id": "obj-46",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            36,
            462,
            20
          ],
          "text": "Transforms incoming MIDI notes using swappable JS scripts in the transforms/ folder."
        }
      },
      {
        "box": {
          "fontface": 1,
          "id": "obj-2",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            67,
            90,
            20
          ],
          "text": "— CONFIG —"
        }
      },
      {
        "box": {
          "id": "obj-3",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            94,
            101,
            40,
            20
          ],
          "text": "in ch"
        }
      },
      {
        "box": {
          "id": "obj-6",
          "maxclass": "number",
          "maximum": 16,
          "minimum": 0,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            94,
            121,
            50,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-9",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            94,
            163,
            55,
            22
          ],
          "text": "s in_ch"
        }
      },
      {
        "box": {
          "id": "obj-33",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            267,
            101,
            60,
            20
          ],
          "text": "transform"
        }
      },
      {
        "box": {
          "id": "obj-34",
          "items": [
            "identity",
            ",",
            "octave-rand",
            ",",
            "scale-rand",
            ",",
            "cc-quantize"
          ],
          "maxclass": "umenu",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "int",
            "",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            267,
            121,
            120,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-37",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            267,
            163,
            40,
            22
          ],
          "text": "s xfm"
        }
      },
      {
        "box": {
          "id": "obj-4",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            177,
            101,
            45,
            20
          ],
          "text": "out ch"
        }
      },
      {
        "box": {
          "id": "obj-7",
          "maxclass": "number",
          "maximum": 16,
          "minimum": 1,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            177,
            121,
            50,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-10",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            177,
            163,
            60,
            22
          ],
          "text": "s out_ch"
        }
      },
      {
        "box": {
          "id": "obj-47",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            414,
            101,
            49,
            20
          ],
          "text": "params"
        }
      },
      {
        "box": {
          "id": "obj-48",
          "maxclass": "textedit",
          "numinlets": 1,
          "numoutlets": 4,
          "outlettype": [
            "",
            "int",
            "",
            ""
          ],
          "parameter_enable": 0,
          "patching_rect": [
            414,
            121,
            254,
            22
          ],
          "text": "values 0|64|127 cn 17"
        }
      },
      {
        "box": {
          "id": "obj-49",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            300,
            458,
            111,
            22
          ],
          "text": "prepend setoptions"
        }
      },
      {
        "box": {
          "id": "obj-50",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            414,
            163,
            70,
            22
          ],
          "text": "s setopts"
        }
      },
      {
        "box": {
          "id": "obj-52",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            101,
            42,
            20
          ],
          "text": "debug"
        }
      },
      {
        "box": {
          "id": "obj-53",
          "maxclass": "toggle",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            "int"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            20,
            121,
            22,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-54",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            163,
            45,
            22
          ],
          "text": "s dbg"
        }
      },
      {
        "box": {
          "id": "obj-55",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            548,
            458,
            45,
            22
          ],
          "text": "r dbg"
        }
      },
      {
        "box": {
          "id": "obj-56",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            548,
            499,
            125,
            22
          ],
          "text": "prepend option debug"
        }
      },
      {
        "box": {
          "id": "obj-51",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            300,
            430,
            56,
            22
          ],
          "text": "r setopts"
        }
      },
      {
        "box": {
          "id": "obj-16",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25,
            430,
            45,
            22
          ],
          "text": "r in_ch"
        }
      },
      {
        "box": {
          "id": "obj-38",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            168,
            430,
            35,
            22
          ],
          "text": "r xfm"
        }
      },
      {
        "box": {
          "id": "obj-17",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "patching_rect": [
            430,
            383,
            50,
            22
          ],
          "text": "notein"
        }
      },
      {
        "box": {
          "id": "obj-35",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            168,
            458,
            107,
            22
          ],
          "text": "prepend transform"
        }
      },
      {
        "box": {
          "id": "obj-42",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            422,
            458,
            65,
            22
          ],
          "text": "pack 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-45",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25,
            458,
            121,
            22
          ],
          "text": "prepend option in_ch"
        }
      },
      {
        "box": {
          "filename": "midi-transform.js",
          "id": "obj-22",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            ""
          ],
          "patching_rect": [
            422,
            690,
            113,
            22
          ],
          "saved_object_attributes": {
            "parameter_enable": 0
          },
          "text": "v8 midi-transform.js",
          "textfile": {
            "filename": "midi-transform.js",
            "flags": 0,
            "embed": 0,
            "autowatch": 1
          }
        }
      },
      {
        "box": {
          "id": "obj-24",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            422,
            739,
            67,
            22
          ],
          "text": "unpack 0 0"
        }
      },
      {
        "box": {
          "id": "obj-25",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            507,
            739,
            60,
            22
          ],
          "text": "r out_ch"
        }
      },
      {
        "box": {
          "id": "obj-26",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 0,
          "patching_rect": [
            422,
            828,
            50,
            22
          ],
          "text": "noteout"
        }
      },
      {
        "box": {
          "id": "obj-101",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "patching_rect": [
            607,
            383,
            45,
            22
          ],
          "text": "ctlin"
        }
      },
      {
        "box": {
          "id": "obj-102",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            601,
            458,
            65,
            22
          ],
          "text": "pack 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-103",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            601,
            499,
            75,
            22
          ],
          "text": "prepend cc"
        }
      },
      {
        "box": {
          "id": "obj-104",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "int",
            "int"
          ],
          "patching_rect": [
            578,
            739,
            67,
            22
          ],
          "text": "unpack 0 0"
        }
      },
      {
        "box": {
          "id": "obj-105",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 0,
          "patching_rect": [
            578,
            828,
            45,
            22
          ],
          "text": "ctlout"
        }
      },
      {
        "box": {
          "id": "obj-106",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            210,
            90,
            20
          ],
          "text": "note buffer size"
        }
      },
      {
        "box": {
          "id": "obj-109",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            149,
            210,
            88,
            20
          ],
          "text": "cc buffer size"
        }
      },
      {
        "box": {
          "id": "obj-107",
          "maxclass": "number",
          "maximum": 128,
          "minimum": 1,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            20,
            230,
            50,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-110",
          "maxclass": "number",
          "maximum": 128,
          "minimum": 1,
          "numinlets": 1,
          "numoutlets": 2,
          "outlettype": [
            "",
            "bang"
          ],
          "parameter_enable": 0,
          "patching_rect": [
            149,
            230,
            50,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-108",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20,
            272,
            37,
            22
          ],
          "text": "s nbs"
        }
      },
      {
        "box": {
          "id": "obj-111",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            149,
            272,
            43,
            22
          ],
          "text": "s ccbs"
        }
      },
      {
        "box": {
          "id": "obj-112",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25,
            517,
            35,
            22
          ],
          "text": "r nbs"
        }
      },
      {
        "box": {
          "id": "obj-114",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25,
            609,
            41,
            22
          ],
          "text": "r ccbs"
        }
      },
      {
        "box": {
          "id": "obj-113",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25,
            545,
            180,
            22
          ],
          "text": "prepend option note_buffer_size"
        }
      },
      {
        "box": {
          "id": "obj-115",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "outlettype": [
            ""
          ],
          "patching_rect": [
            25,
            637,
            169,
            22
          ],
          "text": "prepend option cc_buffer_size"
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "destination": [
            "obj-102",
            2
          ],
          "source": [
            "obj-101",
            2
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-102",
            0
          ],
          "source": [
            "obj-101",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-102",
            1
          ],
          "source": [
            "obj-101",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-103",
            0
          ],
          "source": [
            "obj-102",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-103",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-105",
            0
          ],
          "source": [
            "obj-104",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-105",
            1
          ],
          "source": [
            "obj-104",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-108",
            0
          ],
          "source": [
            "obj-107",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-111",
            0
          ],
          "source": [
            "obj-110",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-113",
            0
          ],
          "source": [
            "obj-112",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-113",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-115",
            0
          ],
          "source": [
            "obj-114",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-115",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-45",
            0
          ],
          "source": [
            "obj-16",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-42",
            2
          ],
          "source": [
            "obj-17",
            2
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-42",
            1
          ],
          "source": [
            "obj-17",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-42",
            0
          ],
          "source": [
            "obj-17",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-104",
            0
          ],
          "source": [
            "obj-22",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-24",
            0
          ],
          "source": [
            "obj-22",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-26",
            1
          ],
          "source": [
            "obj-24",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-26",
            0
          ],
          "source": [
            "obj-24",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-105",
            2
          ],
          "order": 0,
          "source": [
            "obj-25",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-26",
            2
          ],
          "order": 1,
          "source": [
            "obj-25",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-37",
            0
          ],
          "source": [
            "obj-34",
            1
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-35",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-35",
            0
          ],
          "source": [
            "obj-38",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-42",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-45",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-50",
            0
          ],
          "source": [
            "obj-48",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-49",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-49",
            0
          ],
          "source": [
            "obj-51",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-54",
            0
          ],
          "source": [
            "obj-53",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-56",
            0
          ],
          "source": [
            "obj-55",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-22",
            0
          ],
          "source": [
            "obj-56",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-9",
            0
          ],
          "source": [
            "obj-6",
            0
          ]
        }
      },
      {
        "patchline": {
          "destination": [
            "obj-10",
            0
          ],
          "source": [
            "obj-7",
            0
          ]
        }
      }
    ],
    "autosave": 0
  }
}