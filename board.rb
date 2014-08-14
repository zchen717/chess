# require_relative 'pieces.rb'
# require_relative 'slider.rb'
# require_relative 'stepper.rb'
# require_relative 'queen.rb'
# require_relative 'rook.rb'
# require_relative 'bishop.rb'
# require_relative 'king.rb'
# require_relative 'knight.rb'
# require_relative 'pawn.rb'
class Board
  attr_accessor :board

  def initialize(start_condition)
    @board = Array.new(8) { [nil] * 8 }
    start_config if start_condition
  end

  def start_config
    fill_back_row(:white)
    fill_pawns(:white)
    fill_pawns(:black)
    fill_back_row(:black)
  end
  
  def fill_pawns(color)
    row_num = (color == :white) ? 6 : 1
    8.times do |index|
      self[ [row_num, index] ] = Pawn.new([row_num, index], self, color)
    end
  end
  
  def fill_back_row(color)
    row_num = (color == :white) ? 7 : 0
    pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    
    pieces.each_with_index do |piece, index|
      self[ [row_num, index] ] = piece.new([row_num, index], self, color)
    end
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
    ('A'..'H').each do |num|
      print " #{num}  "
    end
    puts
    @board.each_with_index do |row, index|
      print "#{8 - index} "
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

  def in_check?(color)
    color(self.opponent_color(color)).any? do |piece| 
      piece.moves.include?(find_king(color).pos)
    end
  end
  
  def move(start_pos, end_pos, color)
    piece = self[start_pos]
    raise TypeError.new "Wrong color." unless piece.color == color
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

