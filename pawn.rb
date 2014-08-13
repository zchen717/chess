#require_relative 'piece.rb'

class Pawn < Piece
  
  def initialize(pos, board, color)
    @first_move = true
    super(pos, board, color)
  end
  
  
  #moving one space ahead is always a possible move unless there is any piece in front, then you can add the space two spaces ahead
  def moves
    forward_moves + side_moves
  end
  
  def forward_moves
    direction = (@color == :white) ? -1 : 1
    moves = []
    current = @pos.dup
    x, y = current
    x += direction
    if in_bounds?(x, y)
      moves << [x, y] if @board[ [x, y] ].nil?
    end
    
    return [] if moves.empty?
    
    if @first_move
      x += direction 
      p [x, y]
      p board_pos([x, y]).nil?
      moves << [x, y] if board_pos([x, y]).nil?
      @first_move = false
    end
    moves
  end
  
  def capture
    
  end
  
end