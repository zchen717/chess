#require_relative 'piece.rb'

class Stepper < Piece

  def moves
    current = @pos.dup
    moves = []
    moves_array.each do |direction|
      x_coord = current[0] + direction[0]
      y_coord = current[1] + direction[1]
      if in_bounds?(x_coord, y_coord)
        tile = @board[ [x_coord, y_coord] ]
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