class HumanPlayer

  attr_reader :color

  def initialize(color,board)
    @color = color
    @board = board
  end

  def get_input
    "Its your turn, #{color.to_s}"
    input = gets.chomp
    moves = parse_input(input)
    raise InvalidMoveError if !@board[moves[0]].valid_move_seq?(moves[1..-1])
    moves
  end

  def parse_input(input)
    moves = []
    separated_moves = input.split(' ')
    separated_moves.each do |str|
      move = [str[0].to_i,str[1].to_i]
      moves << move
    end
    moves
  end



end
