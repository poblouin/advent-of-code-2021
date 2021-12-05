require '../input_reader'

# Common
def format_input(input)
  input.map { |e| e.split(' -> ') }
end

# Part 1 - Count horizontals + verticals
def part1(formatted_input)
  h = Hash.new(0)

  formatted_input.each do |(a, b)|
    x1, y1 = a.split(',').map(&:to_i)
    x2, y2 = b.split(',').map(&:to_i)

    if x1 == x2
      min_y, max_y = [y1, y2].sort
      (min_y..max_y).each { |n| h[[x1, n]] += 1 }
    elsif y1 == y2
      min_x, max_x = [x1, x2].sort
      (min_x..max_x).each { |n| h[[n, y1]] += 1 }
    end
  end

  puts(h.count { |_, v| v > 1 })
  h
end

# Part 2 - Count diagonals
def part2(formatted_input)
  h = Hash.new(0)

  formatted_input.each do |(a, b)|
    x1, y1 = a.split(',').map(&:to_i)
    x2, y2 = b.split(',').map(&:to_i)
    next if x1 == x2 || y1 == y2

    (min_x, min_y), (max_x, max_y) = [[x1, y1], [x2, y2]].sort
    step = min_y > max_y ? -1 : 1
    (min_x..max_x).each_with_index { |n, i| h[[n, min_y + (step * i)]] += 1 }
  end

  h
end

h1 = part1 format_input InputReader.read
h2 = part2 format_input InputReader.read

puts(h1.merge!(h2) { |_, v1, v2| v1 + v2 }.count { |_, v| v > 1 })
