require 'pry'
require_relative './day_three_utils'

def power_consumption
  inputs = binary_inputs
  input_length = inputs.length
  bit_length = inputs.first.length

  gamma_rate = ''
  epsilon_rate = ''
  sums = []
  0.upto(bit_length - 1) do |bit_index|
    sums[bit_index] ||= 0

    inputs.each do |bit|
      sums[bit_index] += bit[bit_index].to_i
    end
  end

  sums.each do |sum|
    if sum > (input_length / 2)
      gamma_rate += '1'
      epsilon_rate += '0'
    else
      gamma_rate += '0'
      epsilon_rate += '1'
    end
  end

  puts gamma_rate.to_i(2) * epsilon_rate.to_i(2)
end

def part_two
  puts value(1) * value(0)
end

def value(significant_bit)
  insignificant_bit = significant_bit == 1 ? 0 : 1
  inputs = binary_inputs

  bit_index = 0
  while inputs.length > 1
    sum = 0
    inputs.each do |input|
      sum += input[bit_index].to_i
    end
    inputs = if sum >= inputs.length / 2.0
               inputs.filter { |input| input[bit_index] == significant_bit.to_s }
             else
               inputs.filter { |input| input[bit_index] == insignificant_bit.to_s }
             end
    bit_index += 1
  end
  inputs.first.to_i(2)
end

puts 'Part one'
power_consumption
puts 'Part two'
part_two
