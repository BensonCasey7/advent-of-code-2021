require 'pry'
require_relative './day_one_utils'

def sonar_increases
  increases = 0
  sonar_inputs.each_with_index do |depth, index|
    increases += 1 if index + 1 < sonar_inputs.size && sonar_inputs[index + 1] > depth
  end
  puts increases
end

def sonar_window_increases
  inputs = sonar_inputs
  increases = 0
  inputs.each_with_index do |_depth, index|
    next if index + 3 > inputs.size

    increases += 1 if inputs[index..index + 2].sum < inputs[index + 1..index + 3].sum
  end
  puts increases
end

puts 'Part one'
sonar_increases
puts 'Part two'
sonar_window_increases
