require_relative './piece.rb'

require_relative './board.rb'




def valid_move_seq?(move_pos_arr)
  dupped = board.dup
  begin
    dupped[pos].perform_moves!(move_pos_arr)
  rescue IllegalMove
    false
  else
    true
  end
end





  def move_piece(turn_color, start_pos, end_pos)
    raise 'start position is empty' if empty?(start_pos)

    piece = self[start_pos]
    if piece.color != turn_color
      raise 'move your own piece'
    elsif !piece.moves.include?(to_pos)
      raise 'piece cannot perform specified move'
    end

    move_piece!(start_pos, end_pos)
  end


  def move_piece!(start_pos,end_pos)
    piece = self[start_pos]

    self[start_pos] = piece
    self[from_pos] = nil
    piece.pos = to_pos

    nil
  end
