require_relative 'board.rb'

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

  def moves()

  end

  def in_bounds?(x, y)
    (0..7).cover?(x) && (0..7).cover?(y)
  end

  def board_pos(pos)
    @board.board[pos[0]][pos[1]]
  end

end

class Stepper < Piece

  def moves(moves_array)
    current = @pos.dup
    moves = []
    moves_array.each do |direction|
      x_coord = current[0] + direction[0]
      y_coord = current[1] + direction[1]
      if in_bounds?(x_coord, y_coord)
        tile = board_pos([x_coord, y_coord])
          if tile.nil?
            moves << [x_coord, y_coord]
          else
            moves << [x_coord, y_coord] unless @color == tile.color
          end
        end
      end
    moves
  end

end

class Knight < Stepper
  attr_accessor :move_array
  def initialize(pos, board, color)
    @move_array = KNIGHT
    super(pos, board, color)
  end

  def move_dirs
    moves(@move_array)
  end

end

class King < Stepper
  attr_accessor :move_array
  def initialize(pos, board, color)
    @move_array = DIAG + STRT
    super(pos, board, color)
  end

  def move_dirs
    moves(@move_array)
  end

end

class Slider < Piece

  def moves(straights, diagonals)
    moves = []
    current = @pos.dup
    if straights
      STRT.each do |direction|
        current = @pos.dup
        moves.concat(traverse_help(direction, current))
      end
    end

    if diagonals
      DIAG.each do |direction|
        current = @pos.dup
        moves.concat(traverse_help(direction, current))
      end
    end
    moves
  end

  def traverse_help(direction, current)
    moves = []
    while in_bounds?(current[0], current[1])
      current[0] += direction.first
      current[1] += direction.last
      break unless board_pos(current).nil?
      moves << current.dup
    end
    moves
  end
end

class Bishop < Slider
  def move_dirs
    moves(false, true)
  end
end

class Rook < Slider
  def move_dirs
    moves(true, false)
  end
end

class Queen < Slider
  def move_dirs
    moves(true, true)
  end
end

class Pawn < Piece
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  bishop = Bishop.new([3, 3], b, "White")
  p bishop.move_dirs
end
