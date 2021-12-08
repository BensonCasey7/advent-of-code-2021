require 'pry'
require_relative 'day_six_utils'

def simulate(days)
  timers = Hash.new(0)
  input.each { |timer| timers[timer] += 1 }
  days.times do
    babies = timers[0]
    0.upto(7) { |i| timers[i] = timers[i + 1] }
    timers[6] = timers[6] + babies
    timers[8] = babies
  end
  puts timers.values.sum
end

def part_one
  simulate(80)
end

def part_two
  simulate(256)
end

puts 'Part one'
part_one
puts 'Part two'
part_two
