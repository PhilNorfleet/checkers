class InvalidMoveError < RuntimeError
end

class Piece

  attr_reader :color, :pos, :rep


  def initialize(color,board,pos,king = false)
    @color ,@board, @pos, @king = color, board, pos, king
    board.add_piece(self,@pos)
    update_rep
  end

  def inspect
    {:color => @color, :pos => @pos, :king => @king}
  end

  def dup(dup_board)
    Piece.new(color, dup_board, pos, is_king?)
  end

  def update_rep

    if color == :black
      @king ? @rep = "\u200B\u25C9" : @rep = "\u200B\u25CF"
    else
      @king ? @rep = "\u200B\u25CE" : @rep = "\u200B\u25EF"
    end

    nil
  end

  def at_promote_row?
    case color
    when :black
      @pos[0] == 0
    when :white
      @pos[0] == 7
    end
  end


  def maybe_promote
    @king = true if at_promote_row?
    update_rep
  end

  def perform_jump(move_pos)
    return false unless @board.valid_pos?(move_pos)

    jump_diff = [
      (move_pos[0] - pos[0]).fdiv(2),
      (move_pos[1] - pos[1]).fdiv(2)
    ]

    return false unless move_diffs.include?(jump_diff)
    inter_pos = [
      pos[0] + jump_diff[0],
      pos[1] + jump_diff[1]
    ]

    if @board.empty?(inter_pos) || @board[inter_pos].color == color
      return false
    end

    @board[pos] = nil
    @board[inter_pos] = nil
    @pos = move_pos
    @board[move_pos] = self

    maybe_promote

    true

  end

  def perform_slide(move_pos)
    return false unless @board.valid_pos?(move_pos)
    return false unless @board.empty?(move_pos)

    move_diff = [
      move_pos[0] - self.pos[0],
      move_pos[1] - self.pos[1]
    ]

    return false unless move_diffs.include?(move_diff)

    @board[pos] = nil
    @pos = move_pos
    @board[move_pos] = self

    maybe_promote

    true

  end

  def perform_moves!(move_seq)
    if move_seq.length == 1
      unless perform_slide(move_seq[0]) || perform_jump(move_seq[0])
        raise InvalidMoveError
      end
    else
      move_seq.each do |move|
        raise InvalidMoveError unless perform_jump(move)
      end
    end
  end

  def valid_move_seq?(move_seq)
    dupped = @board.dup
    begin
      dupped[pos].perform_moves!(move_seq)
    rescue InvalidMoveError
      false
    else
      true
    end
  end

  def perform_moves(moves)
    if valid_move_seq?(moves)
      perform_moves!(moves)
    else
      raise InvalidMoveError
    end
  end

  def is_king?
      @king
  end

  def move_diffs
    diffs = (color == :white ? [[1,1],[1,-1]] : [[-1,1],[-1,-1]])
    if is_king?
      diffs = [[1,1],[1,-1],[-1,1],[-1,-1]]
    end
    diffs
  end

end
