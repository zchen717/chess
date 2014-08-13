require_relative 'pieces.rb'
require_relative 'slider.rb'
require_relative 'stepper.rb'
require_relative 'queen.rb'
require_relative 'rook.rb'
require_relative 'bishop.rb'
require_relative 'king.rb'
require_relative 'knight.rb'
require_relative 'pawn.rb'

class Board
  attr_accessor :board

  def initialize(start_condition)
    @board = Array.new(8) { [nil] * 8 }
    start_config if start_condition
  end

  def start_config#(start_condition)
    self[ [0, 0] ] = Rook.new([0,0], self, :black)
    self[ [0, 1] ] = Knight.new([0, 1], self, :black)
    self[ [0, 2] ] = Bishop.new([0, 2], self, :black)
    self[ [0, 3] ] = Queen.new([0, 3], self, :black)
    self[ [0, 4] ] = King.new([0, 4], self, :black)
    self[ [0, 5] ] = Bishop.new([0, 5], self, :black)
    self[ [0, 6] ] = Knight.new([0, 6], self, :black)
    self[ [0, 7] ] = Rook.new([0, 7], self, :black)

    8.times do |index|
      self[ [1, index] ] = Pawn.new([1, index], self, :black)
    end

    8.times do |index|
      self[ [6, index] ] = Pawn.new([6, index], self, :white)
    end
    
    self[ [7, 0] ] = Rook.new([7,0], self, :white)
    self[ [7, 1] ] = Knight.new([7, 1], self, :white)
    self[ [7, 2] ] = Bishop.new([7, 2], self, :white)
    self[ [7, 3] ] = Queen.new([7, 3], self, :white)
    self[ [7, 4] ] = King.new([7, 4], self, :white)
    self[ [7, 5] ] = Bishop.new([7, 5], self, :white)
    self[ [7, 6] ] = Knight.new([7, 6], self, :white)
    self[ [7, 7] ] = Rook.new([7, 7], self, :white)
  end
  
  def [](pos)
    x = pos[0]
    y = pos[1]
    @board[x][y]
  end

  def []=(pos, value)
    x = pos[0]
    y = pos[1]
    @board[x][y] = value
  end
  
  def checkmate?(color)
    return false unless in_check?(color)
    
    color(color).all? do |piece|
       p piece unless piece.valid_moves.empty? 
       piece.valid_moves.empty? 
    end
  end
  
  def color(color)
    @board.flatten.compact.select { |piece| piece.color == color }
  end
  
  def display
    print "   "
    (0..7).each do |num|
      print " #{num}  "
    end
    puts
    @board.each_with_index do |row, index|
      print "#{index} "
      row.each do |piece|
        if piece.nil? 
          print "|  |"
        else
          print "|#{piece.class.to_s[0]}#{piece.color.to_s[0]}|" 
        end
      end
      puts
    end
    
  end
  
  def dup_board
    dupped_board = Board.new(false)
    (color(:white) + color(:black)).each do |piece|
      dupped_board[piece.pos] = piece.class.new(piece.pos, dupped_board, piece.color)
    end
    dupped_board
  end
  
  def find_king(color)
    self.color(color).find { |piece| piece.is_a?(King) }
  end
  
  #search all availble pieces of opposite color and check to see if any of  their valid moves include the coordinates of where our color's king is.
  def in_check?(color)
    color(self.opponent_color(color)).any? do |piece| 
      piece.moves.include?(find_king(color).pos)
    end
  end
  
  def move(start_pos, end_pos)
    piece = self[start_pos]
    # error if piece is nil
    raise TypeError.new "There's no piece there." if piece.nil?
    # error if piece.moves does not include end_pos
    raise "That isn't a valid move." unless piece.valid_moves.include?(end_pos)
    self[start_pos], self[end_pos] = nil, piece
    piece.pos = end_pos
    nil
  end
  
  def move!(start_pos, end_pos)
    piece = self[start_pos]
    self[start_pos], self[end_pos] = nil, piece
    piece.pos = end_pos
  end
  
  def opponent_color(color)
    opp_color = (color == :white) ? :black : :white
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new(true)
 
  # should checkmate 
  b.move([6, 5], [5, 5])
  b.move([1, 4], [3, 4])
  b.move([6, 6], [4, 6])
  b.move([0, 3], [4, 7])
  p b.checkmate?(:white)
  
end