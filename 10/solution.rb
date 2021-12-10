require '../input_reader'

PAIRS = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}.freeze

CORRUPTED_VALUES = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}.freeze

INCOMPLETE_VALUES = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}.freeze

def format_input
  InputReader.read
end

def part1_and_part2(formatted_input)
  corrupted_count = 0
  incomplete_count = []

  formatted_input.each do |line|
    catch :corrupted do
      visited = []
      line.chars.each do |s|
        visited.push(PAIRS[s]) && next if PAIRS.key? s

        if visited.pop != s
          corrupted_count += CORRUPTED_VALUES[s]
          throw :corrupted
        end
      end

      incomplete_count.push visited.reverse.reduce(0) { |memo, s| (memo * 5) + INCOMPLETE_VALUES[s] }
    end
  end

  puts corrupted_count
  puts incomplete_count.sort[incomplete_count.size / 2]
end

part1_and_part2(format_input)
