require 'pry'
require_relative 'day_seven_utils'

def part_one
  positions = input
  max = positions.max
  costs = {}
  0.upto(max) do |target|
    fuel = 0
    positions.each { |position| fuel += (position - target).abs }
    costs[target] = fuel
  end
  best = costs.min_by { |_position, cost| cost }
  puts "Position: #{best[0]}\t Cost: #{best[1]}"
end

def part_two
  positions = input
  max = positions.max
  costs = {}
  cost_mapping = cost_map(max)
  0.upto(max) do |target|
    fuel = 0
    positions.each { |position| fuel += cost_mapping[(position - target).abs] }
    costs[target] = fuel
  end
  best = costs.min_by { |_position, cost| cost }
  puts "Position: #{best[0]}\t Cost: #{best[1]}"
end

def cost_map(max)
  costs = [0]
  1.upto(max) { |n| costs[n] = costs[n - 1] + n }
  return costs
end

puts 'Part one'
part_one
puts 'Part two'
part_two
