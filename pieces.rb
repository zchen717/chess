DIAG = [[1, 1], [-1, -1], [-1, 1], [1, -1]]
STRT = [[0, 1], [1, 0], [0, -1], [-1, 0]]
KNIGHT = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

class Piece
  attr_reader :color
  attr_accessor :pos, :board
  
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def moves
    raise NotImplementedError
  end

  def in_bounds?(x, y)
    (0..7).cover?(x) && (0..7).cover?(y)
  end
  
  def valid_moves
    moves.reject { |move| move_into_check?(move) } 
  end
 
  def move_into_check?(end_pos)
    new_board = @board.dup_board
    new_board.move!(@pos, end_pos)
    new_board.in_check?(@color)
  end

  def inspect
    puts "#{self.class} #{self.color} #{self.pos} #{ self.valid_moves }"
  end
  
  def opponent_color
    (@color == :white) ? :black : :white
  end

end

