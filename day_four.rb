require 'pry'
require_relative 'day_four_utils'

class Board
  attr_reader :board
  alias rows board
  attr_accessor :called_numbers

  def initialize(board)
    @board = board
    @called_numbers = []
  end

  def call_number(number)
    called_numbers.push(number)
  end

  def winner?
    (rows + columns).any? { |set| winning_set?(set) }
  end

  def score
    (all_numbers - called_numbers).sum * called_numbers.last
  end

  def winning_set?(set)
    set & called_numbers == set
  end

  def columns
    @columns ||= rows.transpose
  end

  def all_numbers
    board.flatten
  end
end

class Game
  attr_accessor :in_play_boards, :winning_boards

  def initialize(input_boards)
    @in_play_boards = input_boards.map { |input_board| Board.new(input_board) }
    @winning_boards = []
  end

  def call_number(number)
    in_play_boards.each { |board| board.call_number(number) }
    assign_winners
  end

  def winner?
    winning_boards.size.positive?
  end

  def winning_board
    return OpenStruct.new(score: 0) unless winning_boards.size.positive?

    winning_boards.first
  end

  def assign_winners
    in_play_boards.each do |board|
      if board.winner?
        winning_boards.push(board)
        in_play_boards.delete(board)
      end
    end
  end
end

def part_one
  game = Game.new(boards)
  called_numbers.each do |number|
    game.call_number(number)
    next unless game.winner?

    puts game.winning_board.score
    break
  end
end

def part_two
  game = Game.new(boards)
  called_numbers.each do |number|
    game.call_number(number)
    next unless game.winning_boards.size == boards.size

    puts game.winning_boards.last.score
    break
  end
end

puts 'Part one'
part_one
puts 'Part two'
part_two
