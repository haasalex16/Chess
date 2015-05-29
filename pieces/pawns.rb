require_relative 'pieces'

class Pawns < Pieces
  attr_accessor :pawn_motion

  def initialize(position, color, board, rank)
    super(position, color, board, rank)
    @moved = false
    set_moves
  end

  def set_moves
    if color == :black
      @pawn_motion = [[1,0], [1,1], [1,-1], [2,0]]
    else
      @pawn_motion = [[-1,0], [-1,1], [-1,-1], [-2,0]]
    end
  end

  def move(pos)
    super(pos)
    @moved = true
  end

  def moves
    @pawn_motion = pawn_motion.take(3) if @moved
    pos = []
    @pawn_motion.each do |(row,col)|
      pos << [position.first + row, position.last + col]
    end

    all_moves = remove_invalid(pos)
    valid_moves(all_moves)
end

  def valid_moves(all_moves)
    valid_moves = []
    f_moves=[]
    all_moves.each do |(row,col)|
      if col == self.position.last
        f_moves << [row,col]
      else
        if !@board[row][col].nil? && @board[row][col].color != self.color
          valid_moves << [row,col]
        end
      end
    end
    f_moves.each do |(row,col)|
      if @board[row][col].nil?
        valid_moves << [row,col]
      else
        break
      end
    end

    valid_moves
  end

end
