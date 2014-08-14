require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'slider.rb'
require_relative 'stepper.rb'
require_relative 'queen.rb'
require_relative 'rook.rb'
require_relative 'bishop.rb'
require_relative 'king.rb'
require_relative 'knight.rb'
require_relative 'pawn.rb'

class Game
  
  def initialize
    @board = Board.new(true)
    names = start_game_prompt
    @player1 = HumanPlayer.new(names[0], @board, :white)
    @player2 = HumanPlayer.new(names[1], @board, :black)
    play_game
  end
  
  def start_game_prompt
    puts "White player, what is your name?"
    name1 = gets.chomp
    puts "Black player, what is your name?"
    name2 = gets.chomp
    [name1, name2]
  end
  
  def play_game
    @board.display
    until game_over?
      @player1.play_turn
      @board.display
      break if game_over?
      @player2.play_turn
      @board.display
    end
    puts "Checkmate!"
  end
  
  def game_over?
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end

end

class HumanPlayer
  
  def initialize(name, board, color) 
    @name = name
    @board = board
    @color = color
  end
  
  def play_turn
    puts "Please enter in the coordinates of the piece you want to move: "
    start_coord = coord_translate(gets.chomp)
    puts "Please enter in the coordinates you want to move to: "
    end_coord = coord_translate(gets.chomp)
    p "#{start_coord}, #{end_coord}"
    @board.move(start_coord, end_coord, @color)
  end
  
  def coord_translate(coord)
    y_coord, x_coord = coord.split("")
    y_coord.upcase!
    letter_array = ('A'..'H').to_a
    num_array = (1..8).to_a.reverse
    actual_y_index = letter_array.index(y_coord)
    actual_x_index = num_array.index(x_coord.to_i)
    [actual_x_index, actual_y_index]
  end
  
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  
end