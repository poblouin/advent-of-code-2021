require '../input_reader'

# Common
WINNING_COMBINATIONS = [
  [0..4],
  [5..9],
  [10..14],
  [15..19],
  [20..24],
  [0, 5, 10, 15, 20],
  [1, 6, 11, 16, 21],
  [2, 7, 12, 17, 22],
  [3, 8, 13, 18, 23],
  [4, 9, 14, 19, 24]
].freeze

def format_input(input)
  bingo = {
    numbers: input.shift.split(',').map(&:to_i),
    grids: [],
    marked: Array.new(input.size / 5) { Array.new(25, false) }
  }

  input.each_slice(5).with_object(bingo) do |element, accumulator|
    accumulator[:grids].push(element.map(&:split).flatten.map(&:to_i))
  end
end

def mark_grids(grids, marked, number, winning_grids)
  grids.each_with_index do |grid, i|
    next if winning_grids.include?(i)

    number_index = grid.find_index number
    marked[i][number_index] = true unless number_index.nil?
  end
end

def winning_combination?(grid_marked)
  WINNING_COMBINATIONS.any? do |combination|
    grid_marked.values_at(*combination).all?
  end
end

def compute_solution(grids, marked, winner_grid, winner_number)
  unmarked_numbers = grids[winner_grid].reject.with_index do |_number, i|
    marked[winner_grid][i]
  end

  unmarked_numbers.sum * winner_number
end

def play(input, let_giant_squid_win: false)
  bingo = format_input(input)

  winner_grid = nil
  winner_number = nil
  winning_grids = []
  bingo[:numbers].each_with_index do |number, i|
    mark_grids bingo[:grids], bingo[:marked], number, winning_grids
    next if i < 5

    winner_grid = let_giant_squid_win ? find_last_winner(bingo[:marked], winning_grids) : winner_index(bingo[:marked])
    winner_number = number

    break if (winner_grid && !let_giant_squid_win) || (winning_grids.size == bingo[:grids].size && let_giant_squid_win)
  end

  compute_solution bingo[:grids], bingo[:marked], winner_grid, winner_number
end

# Part 1
def winner_index(marked)
  marked.find_index do |element|
    winning_combination? element
  end
end

def part1(input)
  play input
end

# Part 2
def find_last_winner(marked, winning_grids)
  winners = []
  marked.each_with_index do |element, i|
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
