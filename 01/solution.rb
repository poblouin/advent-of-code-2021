# frozen_string_literal: true

input = File.readlines('input.txt').map(&:to_i)

def part1(input)
  input.each_with_index.reduce(0) { |sum, (element, index)| element > input[index - 1] ? sum + 1 : sum }
end

def part2(input)
  current = input[0..2]
  previous = current.map(&:dup)
  count = 0

  input.drop(3).each do |element|
    current.shift
    current.push element

    count += 1 if current.sum > previous.sum

    previous = current.map(&:dup)
  end

  count
end

puts part1 input
puts part2 input
