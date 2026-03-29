var run = require('../transforms/scale-rand');
var scalesModule = require('../transforms/scales');

describe('scale-rand', function() {
    describe('run', function() {
        it('passes through when p=0', function() {
            expect(run(60, 100, { p: 0 }, {})).toEqual([60, 100]);
        });

        it('returns a pitch from the specified scale when p=1', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var result = run(60, 100, { p: 1, root: 'C', scale: 'major' }, {});
            expect(result[1]).toBe(100);
            // C major pitch classes: 0,2,4,5,7,9,11
            var cMajorPCs = [0, 2, 4, 5, 7, 9, 11];
            expect(cMajorPCs).toContain(result[0] % 12);
            Math.random.mockRestore();
        });

        it('never returns the input pitch', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var result = run(60, 100, { p: 1, root: 'C', scale: 'major', range: 2 }, {});
            expect(result[0]).not.toBe(60);
            Math.random.mockRestore();
        });

        it('respects range — result stays within bounds', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var pitch = 60;
            var range = 1;
            var result = run(pitch, 100, { p: 1, root: 'C', scale: 'major', range: range }, {});
            expect(result[0]).toBeGreaterThan(pitch - (range + 1) * 12);
            expect(result[0]).toBeLessThan(pitch + (range + 1) * 12);
            Math.random.mockRestore();
        });

        it('passes through on unknown scale', function() {
            expect(run(60, 100, { p: 1, root: 'C', scale: 'not-a-scale' }, {})).toEqual([60, 100]);
        });

        it('resolves aliases', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var result = run(60, 100, { p: 1, root: 'C', scale: 'major' }, {});
            var resultFull = run(60, 100, { p: 1, root: 'C', scale: 'major-ionian' }, {});
            expect(result[0] % 12).toBe(resultFull[0] % 12);
            Math.random.mockRestore();
        });

        it('max_step limits distance from previous output pitch', function() {
            var history = [{ pitch: 60, velocity: 100, outPitch: 60, outVelocity: 100 }];
            var results = [];
            for (var i = 0; i < 50; i++) {
                var r = run(60, 100, { p: 1, root: 'C', scale: 'major', range: 2, max_step: 3 }, {}, history, []);
                results.push(r[0]);
            }
            results.forEach(function(p) {
                expect(Math.abs(p - 60)).toBeLessThanOrEqual(3);
            });
        });

        it('passes through when no candidates satisfy max_step', function() {
            // prev pitch 60, max_step 0 — only candidate within 0 semitones is 60 itself,
            // which is excluded since it equals the input pitch
            var history = [{ pitch: 60, velocity: 100, outPitch: 60, outVelocity: 100 }];
            var result = run(60, 100, { p: 1, root: 'C', scale: 'major', max_step: 0 }, {}, history, []);
            expect(result).toEqual([60, 100]);
        });

        it('ignores max_step when noteHistory is empty', function() {
            jest.spyOn(Math, 'random').mockReturnValue(0);
            var result = run(60, 100, { p: 1, root: 'C', scale: 'major', max_step: 1 }, {}, [], []);
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
