#require_relative 'board.rb'


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
    new_board.move(@pos, end_pos)
    new_board.in_check?(@color)
  end

  def inspect
    puts "#{self.class} #{self.color}"
  end

end

# class Stepper < Piece
#
#   def moves
#     current = @pos.dup
#     moves = []
#     moves_array.each do |direction|
#       x_coord = current[0] + direction[0]
#       y_coord = current[1] + direction[1]
#       if in_bounds?(x_coord, y_coord)
#         tile = @board[ [x_coord, y_coord] ]
#         if tile.nil?
#           moves << [x_coord, y_coord]
#         else
#           moves << [x_coord, y_coord] unless @color == tile.color
#         end
#       end
#     end
#     moves
#   end
# end

# class Knight < Stepper
#   def moves_array
#     KNIGHT
#   end
# end

# class King < Stepper
#   def moves_array
#     DIAG + STRT
#   end
# end

# class Slider < Piece
#
#   def moves
#     moves = []
#     current = @pos.dup
#     move_dirs.each do |direction|
#       current = @pos.dup
#       moves.concat(traverse_help(direction, current))
#     end
#     moves
#   end
#
#   def traverse_help(direction, current)
#     moves = []
#
#     x, y = current
#     while in_bounds?(x += direction.first, y += direction.last)
#       unless @board[ [x, y] ].nil? # occupied
#         unless @board[ [ x, y] ].color == @color # diff color
#           moves << [x, y]
#         end
#         return moves
#       end
#       moves << [x, y]
#     end
#     moves
#   end
# end

# class Bishop < Slider
#   def move_dirs
#     DIAG
#   end
# end

# class Rook < Slider
#   def move_dirs
#     STRT
#   end
# end

# class Queen < Slider
#   def move_dirs
#     DIAG + STRT
#   end
# end


