var run = require('../transforms/identity');

describe('identity', function() {
    describe('run', function() {
        it('passes notes through unchanged', function() {
            expect(run(60, 100, {}, {})).toEqual([60, 100]);
        });

        it('passes note-off through unchanged', function() {
            expect(run(60, 0, {}, {})).toEqual([60, 0]);
        });

        it('passes extreme pitch values through', function() {
            expect(run(0, 64, {}, {})).toEqual([0, 64]);
            expect(run(127, 64, {}, {})).toEqual([127, 64]);
        });
    });

    describe('runCC', function() {
        it('passes CC through unchanged', function() {
            expect(run.runCC(7, 64, {}, {})).toEqual([7, 64]);
        });

        it('passes CC with extreme values through', function() {
            expect(run.runCC(0, 0, {}, {})).toEqual([0, 0]);
            expect(run.runCC(127, 127, {}, {})).toEqual([127, 127]);
        });
    });
});
