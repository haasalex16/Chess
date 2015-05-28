require './board'

class Chess
  attr_accessor :board_object, :dictionary

  def initialize
    @board_object = Board.new
    create_board_hash
  end

  def create_board_hash
    @dictionary = Hash.new
    columns = %w(a b c d e f g h)

    8.times do |row_idx|
      8.times do |col_idx|
        dictionary[columns[col_idx] + (8 - row_idx).to_s] = [row_idx, col_idx]
      end
    end

    nil
  end

  def play
    system "clear"
    @board_object.display

    until @board_object.game_over?(@board_object.turn)
      puts "#{@board_object.turn} Please move (start,finish)"
      begin
      user_choice = gets.chomp.split(",").map(&:lstrip)
      choice = [@dictionary[user_choice.first], @dictionary[user_choice.last]]
      moved_message = @board_object.move(*choice)

    rescue StandardError
      moved_message = "Invalid Input, Please use comma separated moves (b2,b3)"
    end
      system "clear"

      if moved_message == true
        @board_object.move_tracker[@board_object.turn].unshift("#{user_choice}")
        @board_object.display
      else
        @board_object.display
        puts moved_message
      end

      @turn == :white ? previous_turn = :black : previous_turn = :white
      puts "CHECK!" if @board_object.check?(previous_turn)
    end


    @board_object.toggle_turn

    return "#{@board_object.turn.upcase} WINS!" if @board_object.check?(@board_object.turn)
    "Draw"
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new; nil
  puts game.play
end
