require_relative 'pieces'

class Sliding_Pieces < Pieces

    DIAGONAL_MOTION=[[1,1],[-1,1],[-1,-1],[1,-1]]
    STRAIGHT_MOTION = [[-1,0],[1,0],[0,1],[0,-1]]

    DIC = { :rook => STRAIGHT_MOTION, :bishop => DIAGONAL_MOTION, :queen => DIAGONAL_MOTION+STRAIGHT_MOTION}

  def moves
    pos = []
    DIC[self.rank].each do |(row,col)|
      (1...8).to_a.each do |idx|
        pos << [position.first + row*idx , position.last + col*idx]
        break if remove_invalid([pos[-1]]) == []

        last_obj = @board[pos.last.first][pos.last.last]
        break unless last_obj.nil?
      end
    end

    all_moves = remove_invalid(pos)
    valid_moves(all_moves)
  end

end
