class Game

  def initialize(test_stuff = false, empty = false, size = 8)
    @board = Board.new(test_stuff, empty, size)
    @w_player = HumanPlayer.new(:white,@board)
    @b_player = HumanPlayer.new(:black,@board)
    @board.render
  end

  def play
    until @board.pieces.all? { |piece| piece.color == :white } ||
      @board.pieces.all? { |piece| piece.color == :black }
      [@w_player,@b_player].each do |player|
        color = player.color
        puts "#{color.to_s} make your move"
        moves = player.get_input
        @board[moves[0]].perform_moves(moves[1..-1])
        @board.render
      end
    end
  end

end
