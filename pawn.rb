#require_relative 'piece.rb'

class Pawn < Piece
  
  def initialize(pos, board, color)
    @first_move = true
    super(pos, board, color)
  end
  
  
  #moving one space ahead is always a possible move unless there is any piece in front, then you can add the space two spaces ahead
  def moves
    forward_moves + capture_moves
  end
  
  def get_direction
    (@color == :white) ? -1 : 1
  end
  
  def forward_moves
    direction = get_direction
    moves = []
    x, y = @pos
    x += direction
    if in_bounds?(x, y)
      moves << [x, y] if @board[ [x, y] ].nil?
    end
    
    if @first_move
      x += direction 
      moves << [x, y] if @board[ [x, y] ].nil?
      @first_move = false
    end
    moves
  end
  
  #pawn can capture on diagonals
  def capture_moves
    direction = get_direction
    moves = []
    x, y = @pos
    x += direction
    y += 1
    if @board[ [x, y] ] && @board[ [x,y] ].color == opponent_color
      moves << [x, y]
    end 
    y -= 2
    if @board[ [x, y] ] && @board[ [x,y] ].color == opponent_color
      moves << [x, y]
    end
    moves
  end
    
end