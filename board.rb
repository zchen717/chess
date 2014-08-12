# require_relative "pieces.rb"

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { [nil] * 8 }
    start_config
  end

  def start_config
    @board[0][0] = Rook.new([0,0], self, "Black")
    @board[0][1] = Knight.new([0, 1], self, "Black")
    @board[0][2] = Bishop.new([0, 2], self, "Black")
    @board[0][3] = Queen.new([0, 3], self, "Black")
    @board[0][4] = King.new([0, 4], self, "Black")
    @board[0][5] = Bishop.new([0, 5], self, "Black")
    @board[0][6] = Knight.new([0, 6], self, "Black")
    @board[0][7] = Rook.new([0, 7], self, "Black")

    8.times do |index|
      @board[1][index] = Pawn.new([1, index], self, "Black")
    end

     8.times do |index|
       board[6][index] = Pawn.new([6, index], self, "White")
     end

    @board[7][0] = Rook.new([7,0], self, "White")
    @board[7][1] = Knight.new([7, 1], self, "White")
    @board[7][2] = Bishop.new([7, 2], self, "White")
    @board[7][3] = Queen.new([7, 3], self, "White")
    @board[7][4] = King.new([7, 4], self, "White")
    @board[7][5] = Bishop.new([7, 5], self, "White")
    @board[7][6] = Knight.new([7, 6], self, "White")
    @board[7][7] = Rook.new([7, 7], self, "White")
  end
end
