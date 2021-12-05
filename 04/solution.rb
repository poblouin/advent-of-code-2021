require '../input_reader'

# Common
def format_input(input)
  bingo = {
    numbers: input.shift.split(',').map(&:to_i),
    grids: []
  }

  input.each_slice(5).with_object(bingo) do |element, accumulator|
    accumulator[:grids].push(element.map(&:split).flatten.map(&:to_i))
  end
end

def mark_grids(grids, number, winning_grids)
  grids.each_with_index do |grid, i|
    next if winning_grids.include?(i)

    number_index = grid.find_index number
    grids[i][number_index] = nil unless number_index.nil?
  end
end

def winning_combination?(grid)
  grid_row_column = grid.each_slice(5).to_a
  return true if grid_row_column.any? { |row| row.compact.empty? }
  return true if grid_row_column.transpose.any? { |column| column.compact.empty? }

  false
end

def play(input, let_giant_squid_win: false)
  bingo = format_input(input)

  winning_grids = []
  bingo[:numbers].each do |number|
    mark_grids bingo[:grids], number, winning_grids
    winner_grid = let_giant_squid_win ? find_last_winner(bingo[:grids], winning_grids) : winner_index(bingo[:grids])

    if (winner_grid && !let_giant_squid_win) || (winning_grids.size == bingo[:grids].size && let_giant_squid_win)
      return bingo[:grids][winner_grid].compact.sum * number
    end
  end
end

# Part 1
def winner_index(grids)
  grids.find_index do |element|
    winning_combination? element
  end
end

def part1(input)
  play input
end

# Part 2
def find_last_winner(grids, winning_grids)
  winners = []
  grids.each_with_index do |element, i|
    next if winning_grids.include?(i)

    winning_combination?(element) && winners.push(i)
  end

  winning_grids.push(*winners) if winners
  winners.nil? ? nil : winners.last
end

def part2(input)
  play input, let_giant_squid_win: true
end

p part1(InputReader.read.reject!(&:empty?))
p part2(InputReader.read.reject!(&:empty?))
