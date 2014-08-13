#require_relative "piece.rb"

class Slider < Piece

  def moves
    moves = []
    current = @pos.dup
    move_dirs.each do |direction|
      current = @pos.dup
      moves.concat(traverse_help(direction, current))
    end
    moves
  end

  def traverse_help(direction, current)
    moves = []

    x, y = current
    while in_bounds?(x += direction.first, y += direction.last)
      unless @board[ [x, y] ].nil? # occupied
        unless @board[ [ x, y] ].color == @color # diff color
          moves << [x, y]
        end
        return moves
      end
      moves << [x, y]
    end
    moves
  end
end