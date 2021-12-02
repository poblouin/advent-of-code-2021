const fs = require("fs");

const input = fs.readFileSync("./input.txt", "utf8").split("\n").map(s => Number(s));

const part1 = () =>
  input.reduce(
    (accumulator, currentValue, currentIndex, array) =>
      currentValue > array[currentIndex - 1]
        ? accumulator + 1
        : accumulator,
    0
  );

const part2 = () => {
  let count = 0;
  let delimiter = input[0];
  let previousWindow = input[0] + input[1] + input[2];

  for (let i = 3; i < input.length; i++) {
    const currentWindow = previousWindow - delimiter + input[i];

    if (currentWindow > previousWindow) count += 1

    delimiter = input[i - 2];
    previousWindow = currentWindow;
  }

  return count;
}

process.stdout.write(`Part 1: ${part1()}\n`);
process.stdout.write(`Part 2: ${part2()}`);
