module.exports = [
    {
        files: ["transforms/*.js", "midi-transform.js"],
        languageOptions: {
            ecmaVersion: 5,
            sourceType: "script",
            globals: {
                // Max v8 globals
                post: "readonly",
                inlet: "readonly",
                outlet: "readonly",
                inlets: "writable",
                outlets: "writable",
                require: "readonly",
                module: "writable",
            }
        },
        rules: {
            "no-var": "off",          // var is required in ES5
            "prefer-const": "off",
            "prefer-arrow-callback": "off",
            "no-undef": "error",
            "quote-props": ["error", "always"],      // catch missing Max globals
        }
    },
    {
        files: ["tests/*.js", "jest.config.js"],
        languageOptions: {
            ecmaVersion: 2020,
            sourceType: "script",
            globals: {
                require: "readonly",
                module: "readonly",
                describe: "readonly",
                it: "readonly",
                expect: "readonly",
                jest: "readonly",
                global: "readonly",
            }
        }
    }
];
