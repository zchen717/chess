class Pawn < Piece

  def initialize(pos, board, color)
    @first_move = true
    super(pos, board, color)
  end

  def moves
    forward_moves + capture_moves
  end

  def get_direction
    (@color == :white) ? -1 : 1
  end

  def forward_moves
     x, y = @pos
     get_direction
     one_step = [x + get_direction, y]
     return [] unless in_bounds?(one_step[0], one_step[1]) && @board[ [one_step[0], one_step[1]] ].nil?

     steps = [one_step]
     two_step = [x + 2 * get_direction, y]
     steps << two_step if @first_move && @board[ [two_step[0], two_step[1]] ].nil?
     steps
   end

   def capture_moves
     x, y = pos
     side_moves = [[x + get_direction, y - 1], [x + get_direction, y + 1]]

     side_moves.select do |new_pos|
       next false unless in_bounds?(new_pos[0], new_pos[1])

       threatened_piece = board[new_pos]
       threatened_piece && threatened_piece.color != color
     end
   end

end