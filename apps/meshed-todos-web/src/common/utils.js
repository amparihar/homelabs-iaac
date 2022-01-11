
// @flow
export const utils = {
  range: (start, end) =>
    Array.from({ length: end - start + 1 }, (_, i) => start + i),

  random: (min, max) => min + Math.floor(max * Math.random())
};


