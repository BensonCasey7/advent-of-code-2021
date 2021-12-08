require 'pry'
require_relative './day_two_utils'

def position
  x = 0
  y = 0
  instruction_inputs.each do |instruction|
    splits = instruction.split(' ')
    case splits[0]
    when 'up'
      y -= splits[1].to_i
    when 'down'
      y += splits[1].to_i
    when 'forward'
      x += splits[1].to_i
    end
  end
  puts x * y
end

def position_with_aim
  x = 0
  y = 0
  aim = 0
  instruction_inputs.each do |instruction|
    splits = instruction.split(' ')
    case splits[0]
    when 'up'
      aim -= splits[1].to_i
    when 'down'
      aim += splits[1].to_i
    when 'forward'
      x += splits[1].to_i
      y += (aim * splits[1].to_i)
    end
  end
  puts x * y
end

puts 'Part one'
position
puts 'Part two'
position_with_aim
