require 'byebug'

class Pieces
  RENDER_HASH = { black: {pawn: "\u265f",
                          knight: "\u265e",
                          king: "\u265a",
                          queen: "\u265b",
                          rook: "\u265c",
                          bishop: "\u265d"},
                  white: {pawn: "\u2659",
                          knight: "\u2658",
                          king: "\u2654",
                          queen: "\u2655",
                          rook: "\u2656",
                          bishop: "\u2657"}
                }

  attr_accessor :position, :color, :board, :rank

  def initialize(position, color, board, rank)
    @position = position
    @color = color
    @board = board
    @rank = rank
  end

  def move(pos)
    @board[@position.first][@position.last] = nil
    @board[pos.first][pos.last] = self
    @position = pos
  end

  def valid_moves(all_moves)
    valid_moves = []
    all_moves.each do |(row, col)|
      if @board[row][col].nil?
        valid_moves << [row,col]
        next
      end
      unless @board[row][col].color == @color
        valid_moves << [row, col]
      end
    end

    valid_moves
  end

  def remove_invalid(pos)
    pos -= [@position]
    pos.select{ |(row, col)| row.between?(0,7) && col.between?(0,7)}
  end

  def render
    RENDER_HASH[color][self.rank]
  end

end
