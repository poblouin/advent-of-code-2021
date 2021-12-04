require '../input_reader'

def format_input(input, has_aim: false)
  behaviour = has_aim ? :aim : :depth

  input.map do |element|
    splitted = element.split
    key = splitted[0] == 'forward' ? :position : behaviour
    value = splitted[0] == 'up' ? -splitted[1].to_i : splitted[1].to_i

    [key, value]
  end
end

def part1(input)
  format_input(input).each_with_object({ position: 0, depth: 0 }) do |element, accumulator|
    accumulator[element[0]] += element[1]
  end
end

def part2(input)
  format_input(input, has_aim: true).each_with_object({ position: 0, depth: 0, aim: 0 }) do |element, accumulator|
    key = element[0]
    value = element[1]

    accumulator[key] += value
    accumulator[:depth] += accumulator[:aim] * value if key == :position
  end
end

puts part1(InputReader.read).values.inject(:*)
puts part2(InputReader.read).slice(:position, :depth).values.inject(:*)
