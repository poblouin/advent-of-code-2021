require 'set'
require '../input_reader'

def format_input
  InputReader.read.first.split(',').map(&:to_i)
end

def part1(formatted_input)
  min, max = formatted_input.sort!.minmax
  max_sum = 0
  (min..max).each do |pos|
    sum = formatted_input.map { |n| (n - pos).abs }.sum
    return max_sum if sum > max_sum && max_sum != 0

    max_sum = sum
  end
end

def fuel_consumption_part2(n)
  n * (n + 1) / 2
end

def part2(formatted_input)
  min, max = formatted_input.sort!.minmax
  max_sum = 0
  (min..max).each do |pos|
    sum = formatted_input.map { |n| fuel_consumption_part2(((n - pos).abs)) }.sum
    return max_sum if sum > max_sum && max_sum != 0

    max_sum = sum
  end
end

puts part1(format_input)
puts part2(format_input)
