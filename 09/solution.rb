require '../input_reader'

def format_input
  InputReader.read.map { |s| s.chars.map(&:to_i) }
end

def get_adjacent_numbers(row, col, grid)
  adjacent = []
  adjacent << grid[row - 1][col] if row - 1 >= 0
  adjacent << grid[row + 1][col] if row + 1 < grid.length
  adjacent << grid[row][col - 1] if col - 1 >= 0
  adjacent << grid[row][col + 1] if col + 1 < grid[0].length

  adjacent
end

def part1(grid)
  lowest = []
  grid.each_index do |row|
    grid[row].each_index do |col|
      adjacent = get_adjacent_numbers(row, col, grid)
      lowest << [row, col] if adjacent.all? { |n| n > grid[row][col] }
    end
  end

  pp lowest
end

puts part1(format_input).map { |row, col| format_input[row][col] }.sum { |n| n + 1 }
