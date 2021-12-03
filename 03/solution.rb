# frozen_string_literal: true

input = File.readlines 'input.txt', chomp: true

# Common
def count_bits_by_column(input, index: nil)
  size = index.nil? ? input.first.size : 1
  columns_bit_count = Array.new(size) { { '0' => 0, '1' => 0 } }

  input.each_with_object(columns_bit_count) do |element, accumulator|
    if index
      accumulator[0][element[index]] += 1
    else
      element.each_char.with_index { |char, i| accumulator[i][char] += 1 }
    end
  end
end

# Part 1
def part1(input)
  columns_bit_count = count_bits_by_column input

  rates = { gamma: '', epsilon: '' }
  columns_bit_count.each_with_object(rates) do |column, accumulator|
    least = column['0'] < column['1'] ? '0' : '1'
    most = least == '0' ? '1' : '0'

    accumulator[:gamma] += most
    accumulator[:epsilon] += least
  end

  rates.values.map { |binary_s| binary_s.to_i(2) }.inject(:*)
end

# Part 2
def find_bit_to_keep(bit_count, rating)
  least = bit_count['0'] < bit_count['1'] ? '0' : '1'
  most = least == '0' ? '1' : '0'

  if bit_count['0'] == bit_count['1']
    rating == :oxygen ? '1' : '0'
  else
    rating == :oxygen ? most : least
  end
end

def find_rating(input, rating, index: 0)
  return input.first.to_i(2) if input.size == 1

  bit_count = count_bits_by_column(input, index: index).first
  bit = find_bit_to_keep(bit_count, rating)
  filtered_input = input.select { |binary_s| binary_s[index] == bit }

  find_rating(filtered_input, rating, index: index + 1)
end

def part2(input)
  find_rating(input, :oxygen) * find_rating(input, :co2)
end

puts part1(input)
puts part2(input)
