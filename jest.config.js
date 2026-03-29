module.exports = {
    testMatch: ["**/tests/**/*.test.js"],
    setupFiles: ["<rootDir>/tests/setup.js"],
    moduleNameMapper: {
        // scale-rand.js uses Max-style paths (resolved from patch root).
        // Remap to the actual file location for Node.js/Jest.
        "^\\./transforms/scales\\.js$": "<rootDir>/transforms/scales.js"
    }
};
