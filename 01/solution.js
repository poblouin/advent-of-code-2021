const fs = require("fs");

const input = fs.readFileSync("./input", "utf8").split("\n");

const part1 = input.reduce(
  (accumulator, currentValue, currentIndex, array) =>
    Number(currentValue) > Number(array[currentIndex - 1])
      ? accumulator + 1
      : accumulator,
  0
);

process.stdout.write(`Part 1: ${part1}`);
