require '../input_reader'

def format_input
  InputReader.read.map do |line|
    {
      patterns: line.split[..9].sort_by(&:size).map { |s| s.chars.sort.join },
      digits: line.split[-4..].map { |s| s.chars.sort.join }
    }
  end
end

# :troll:
def part1(formatted_input)
  formatted_input.sum { |line| line[:digits].count { |s| [2, 3, 4, 7].include? s.size } }
end

def diff_string(a, b)
  a.chars - b.chars
end

def find_numbers_six_wires(numbers, with_six_wires)
  numbers[9] = with_six_wires.find { |n| !numbers[4].include?(diff_string(numbers[8], n).first) }
  numbers[6] = with_six_wires.reject { |n| n == numbers[9] }.find { |n| numbers[7].include?(diff_string(numbers[9], n).first) }
  numbers[0] = (with_six_wires - [numbers[9], numbers[6]]).first
end

def find_numbers_five_wires(numbers, with_five_wires)
  numbers[2] = with_five_wires.find { |n| diff_string(numbers[4], n).size == 2 }
  numbers[3] = with_five_wires.reject { |n| n == numbers[2] }.find { |n| diff_string(n, numbers[1]).size == 3 }
  numbers[5] = (with_five_wires - [numbers[2], numbers[3]]).first
end

def part2(formatted_input)
  formatted_input.each.reduce(0) do |sum, line|
    numbers = Array.new(10)
    numbers[1] = line[:patterns].shift
    numbers[7] = line[:patterns].shift
    numbers[4] = line[:patterns].shift
    numbers[8] = line[:patterns].pop
    find_numbers_six_wires numbers, line[:patterns][-3..]
    find_numbers_five_wires numbers, line[:patterns][..2]

    sum + line[:digits].each_with_object([]) { |d, a| a << numbers.index(d).to_s }.join.to_i
  end
end

puts part1(format_input)
puts part2(format_input)
