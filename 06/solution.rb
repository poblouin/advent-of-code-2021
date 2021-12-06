require '../input_reader'

def format_input
  InputReader.read.first.split(',').map(&:to_i)
end

# The naive implementation, won't work for part 2.
def part1(input)
  80.times.with_object(input) do |_, memo|
    new_fish = 0
    memo.map! do |n|
      new_fish += 1 if n.zero?
      n.zero? ? 6 : n - 1
    end.push(*Array.new(new_fish, 8))
  end.size
end

# The improved implementation.
def part2(input)
  fish_count = input.each_with_object(Array.new(9, 0)) { |n, memo| memo[n] += 1 }

  256.times do
    new_fish_count = fish_count.shift
    fish_count[6] += new_fish_count
    fish_count[8] = new_fish_count
  end

  fish_count.sum
end

p part1(format_input)
p part2(format_input)
