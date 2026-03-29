var transform = require('../transforms/cc-quantize');
var runCC = transform.runCC;

describe('cc-quantize', function() {
    describe('run', function() {
        it('passes notes through unchanged', function() {
            expect(transform(60, 100, {}, {})).toEqual([60, 100]);
        });
    });

    describe('runCC', function() {
        it('maps to lowest bucket', function() {
            expect(runCC(7, 0, { values: '0|64|127' }, {})).toEqual([7, 0]);
        });

        it('maps to middle bucket', function() {
            expect(runCC(7, 64, { values: '0|64|127' }, {})).toEqual([7, 64]);
        });

        it('maps to highest bucket', function() {
            expect(runCC(7, 127, { values: '0|64|127' }, {})).toEqual([7, 127]);
        });

        it('uses default values when none specified', function() {
            var result = runCC(7, 0, {}, {});
            expect(result[0]).toBe(7);
            expect([0, 64, 127]).toContain(result[1]);
        });

        it('preserves controller number', function() {
            expect(runCC(18, 100, { values: '0|64|127' }, {})[0]).toBe(18);
        });

        it('quantizes only the matching cn', function() {
            expect(runCC(17, 100, { values: '0|127', cn: 17 }, {})).toEqual([17, 127]);
        });

        it('passes through non-matching cn', function() {
            expect(runCC(18, 100, { values: '0|127', cn: 17 }, {})).toEqual([18, 100]);
        });

        it('quantizes all controllers when cn is not set', function() {
            expect(runCC(18, 100, { values: '0|127' }, {})).toEqual([18, 127]);
            expect(runCC(7, 100, { values: '0|127' }, {})).toEqual([7, 127]);
        });

        it('handles a single target value', function() {
            expect(runCC(7, 64, { values: '42' }, {})).toEqual([7, 42]);
        });
    });
});
