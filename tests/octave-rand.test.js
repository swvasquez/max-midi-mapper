var run = require('../transforms/octave-rand');

describe('octave-rand', function() {
    describe('run', function() {
        it('passes through when p=0', function() {
            expect(run(60, 100, { p: 0 }, {})).toEqual([60, 100]);
        });

        it('always shifts when p=1', function() {
            var result = run(60, 100, { p: 1, range: 1 }, {});
            expect(result[1]).toBe(100);
            expect(result[0]).not.toBe(60);
        });

        it('shifts by exactly one octave with range=1', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var result = run(60, 100, { p: 1, range: 1 }, {});
            expect(Math.abs(result[0] - 60) % 12).toBe(0);
            Math.random.mockRestore();
        });

        it('clamps result to 0-127', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var result = run(4, 100, { p: 1, range: 1 }, {});
            expect(result[0]).toBeGreaterThanOrEqual(0);
            expect(result[0]).toBeLessThanOrEqual(127);
            Math.random.mockRestore();
        });

        it('passes through when no valid shifts exist (range=0)', function() {
            expect(run(60, 100, { p: 1, range: 0 }, {})).toEqual([60, 100]);
        });

        it('never returns the input pitch when shifting', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var result = run(60, 100, { p: 1, range: 2 }, {});
            expect(result[0]).not.toBe(60);
            Math.random.mockRestore();
        });
    });

    describe('runCC', function() {
        it('passes CC through unchanged', function() {
            expect(run.runCC(7, 64, {}, {})).toEqual([7, 64]);
        });
    });
});
