require 'pry'
require_relative 'day_five_utils'

class Grid
  attr_reader :lines
  attr_accessor :grid

  def initialize(lines, x_size, y_size)
    @lines = lines
    @grid = build_grid(x_size, y_size)
    mark_grid
  end

  def overlaps
    grid.flatten.reject { |value| value < 2 }
  end

  def mark_grid
    lines.each do |line|
      line.path.each do |coordinate|
        grid[coordinate[0]][coordinate[1]] += 1
      end
    end
  end

  def build_grid(x_size, y_size)
    Array.new(y_size) { Array.new(x_size, 0) }
  end
end

class Line
  attr_reader :x_start, :y_start, :x_end, :y_end, :ignore_diagonals

  def initialize(x_start, y_start, x_end, y_end, ignore_diagonals: false)
    @x_start = x_start
    @y_start = y_start
    @x_end = x_end
    @y_end = y_end
    @ignore_diagonals = ignore_diagonals
  end

  def path
    if x_start == x_end
      range(line_length) { |number| [x_start, [y_start, y_end].min + number] }
    elsif y_start == y_end
      range(line_length) { |number| [[x_start, x_end].min + number, y_start] }
    elsif ignore_diagonals
      []
    else
      if x_start < x_end
        if y_start < y_end
          range(line_length) { |number| [x_start + number, y_start + number] }
        else
          range(line_length) { |number| [x_start + number, y_start - number] }
        end
      else
        if y_start < y_end
          range(line_length) { |number| [x_start - number, y_start + number] }
        else
          range(line_length) { |number| [x_end + number, y_end + number] }
        end
      end
    end
  end

  def line_length
    @line_length ||= [(x_end - x_start).abs, (y_end - y_start).abs].max
  end

  def range(line_length, &block)
    0.upto(line_length).map { |number| block.call(number) }
  end
end

def part_one
  lines = line_coordinates.map { |line| Line.new(*line, ignore_diagonals: true) }
  grid = Grid.new(lines, 1000, 1000)
  puts grid.overlaps.size
end

def part_two
  lines = line_coordinates.map { |line| Line.new(*line) }
  grid = Grid.new(lines, 1000, 1000)
  puts grid.overlaps.size
end

puts 'Part one'
part_one
puts 'Part two'
part_two
