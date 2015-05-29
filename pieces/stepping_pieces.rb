require_relative 'pieces'

class Stepping_Pieces < Pieces

    KNIGHT_MOTION= [ [1,2],[2,1],[1,-2],[-2,1],[-1,2],[2,-1],[-1,-2],[-2,-1]]
    KING_MOTION=[[0,1],[0,-1],[1,0],[1,1],[1,-1],[-1,-1],[-1,0],[-1,1]]

    DIC= {:king=>KING_MOTION,:knight=>KNIGHT_MOTION}

  def moves
      pos=[]
      DIC[self.rank].each do |(row, col)|
        pos << [position.first + row, position.last + col]
      end

      all_moves = remove_invalid(pos)
      valid_moves(all_moves)
  end

end
