class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def get_input
    "Its your turn, #{color.to_s}"
    input = gets.chomp
    moves = parse_input(input)
    raise InvalidMoveError if !moves[0].valid_move_seq?(moves[1..-1])
    moves
  end

  def parse_input(input)
    moves = []
    separated_moves = input.split(' ')
    separated_moves.map!{ |char| char.to_i }
    end
    seperated_moves.each do |move|
      moves << [move[0],move[1]]
    end
    moves
  end



end
