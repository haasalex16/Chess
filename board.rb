require './piece'

class Board



  attr_accessor :board, :dictionary

  ORDER= [:rook, nil, :bishop, :queen, nil, :bishop, nil, :rook]
  K_UNITS = [nil, :knight, nil, nil, :king, nil,:knight, nil]

  def initialize
    @board = Array.new(8) {Array.new(8)}
    build_board
  end

  def build_board

    8.times do |col|
      @board[1][col] = Pawns.new([1,col],:white, [], :pawn)
      @board[6][col] = Pawns.new([6,col],:black, [], :pawn)
      @board[0][col] = Sliding_Pieces.new([0,col],:white,[],ORDER[col])
      @board[7][col] = Sliding_Pieces.new([7,col],:black,[],ORDER[col])
      next if K_UNITS[col].nil?
      @board[0][col] = Stepping_Pieces.new([0,col],:white,[],K_UNITS[col])
      @board[7][col] = Stepping_Pieces.new([7,col],:black,[],K_UNITS[col])
    end

  end

  def create_board_hash
    @dictionary = Hash.new
    columns = %w(a b c d e f g h)

    @board.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        dictionary[columns[col_idx] + (8 - row_idx).to_s] = [row_idx,col_idx]
      end
    end

    nil
  end




end