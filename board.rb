
require_relative './pieces/sliding_pieces.rb'

require_relative  './pieces/stepping_pieces'
require_relative  './pieces/pawns'
require 'yaml'
require 'colorize'

class Board

  attr_accessor :board, :dictionary, :turn, :move_tracker

  ORDER= [:rook, nil, :bishop, :queen, nil, :bishop, nil, :rook]
  K_UNITS = [nil, :knight, nil, nil, :king, nil,:knight, nil]

  def initialize
    @board = Array.new(8) {Array.new(8)}
    build_board
    @turn = :white
    @move_tracker = { :white => Array.new(8){"        "}, :black => Array.new(8){"        "} }
  end

  def toggle_turn
    @turn == :white ? @turn = :black : @turn = :white
  end

  def build_board

    8.times do |col|
      @board[1][col] = Pawns.new([1,col],:black,          @board, :pawn)
      @board[6][col] = Pawns.new([6,col],:white,          @board, :pawn)
      @board[0][col] = Sliding_Pieces.new([0,col],:black, @board,ORDER[col])
      @board[7][col] = Sliding_Pieces.new([7,col],:white, @board,ORDER[col])
      next if K_UNITS[col].nil?
      @board[0][col] = Stepping_Pieces.new([0,col],:black, @board,K_UNITS[col])
      @board[7][col] = Stepping_Pieces.new([7,col],:white,@board,K_UNITS[col])
    end

  end

  def display
    count = 8
    puts " A  B  C  D  E  F  G  H              WHITE  :  BLACK"
    color_count = 1
    @board.each do |row|
      drawn=''
      row.each do | cell |
        if cell.nil?
          if color_count % 2 == 0
            drawn << "   ".colorize(:background => :light_black)
          else
            drawn << "   "
          end
        else
          string =  " #{cell.render} "
          if color_count % 2 == 0
            string = string.colorize(:background => :light_black)
          end
          drawn << string
        end
        color_count += 1
      end
      color_count += 1
      drawn << " #{count.to_s}          "
      drawn <<  @move_tracker[:black][8 - count].to_s[1..-2].to_s.gsub("\"","")
      drawn << "  |  "
      drawn <<  @move_tracker[:white][8 - count].to_s[1..-2].to_s.gsub("\"","")
      count -= 1
      puts drawn
    end

    nil
  end

  def board_dup
    YAML.load(self.to_yaml)

  end

  def move(start_pos, end_pos)
    piece = @board[start_pos.first][start_pos.last]
    return "No Piece at this Location" if piece.nil?
    return "Please Choose One of Your Pieces" if piece.color != @turn
    return "Invalid Move" unless piece.moves.include?(end_pos)

    test_board = self.board_dup

    test_board.board[start_pos.first][start_pos.last].move(end_pos)
    test_board.toggle_turn
    return "Cannot Put Self Into Check" if test_board.check?(test_board.turn)

    piece.move(end_pos)
    toggle_turn

    true
  end

  def game_over?(color)
    poss_move_set = check?(color, true)

    poss_move_set.each do |(from , to)|
      new_board = self.board_dup
      if new_board.move(from, to) == true
        return false
      end
    end
    true
  end

  def check?(color, more = false)
    possible_moves = []
    king_pos = []
    poss_move_set = []

    @board.each do |row|
      row.each do |cell|
        next if cell.nil?
        if cell.color != color && cell.rank == :king
          king_pos = cell.position
        elsif cell.color == color
          possible_moves.concat(cell.moves)

          cell.moves.each do |move|
            poss_move_set << [cell.position,move]
          end
        end
      end
    end

    return poss_move_set if more
    possible_moves.include?(king_pos)
  end

end
