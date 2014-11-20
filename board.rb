# coding: utf-8

class Board

  attr_reader :board

  def initialize(test_stuff = false, empty = false, size = 8)
    @size = size
    @board = Array.new(8) { Array.new(8) }
    @test = test_stuff
    init_pieces unless empty || test_stuff
    init_test if test_stuff
  end

  def inspect

  end

  def init_test
    Piece.new(:black, self, [5,1] )
    Piece.new(:white, self, [4,2] )
    Piece.new(:white, self, [2,4] )
  end


  def [](pos)
    raise 'invalid pos' unless valid_pos?(pos)

    x,y = pos
    @board[x][y]
  end


  def []=(pos,piece)
    raise 'invalid pos' unless valid_pos?(pos)

    x,y = pos
    @board[x][y] = piece
  end

  def add_piece(piece,pos)

    raise 'position not empty' unless empty?(pos)

    self[pos] = piece

  end


  def pieces
    @board.flatten.compact
  end


  def valid_pos?(pos)
      pos.all? { |i| i.between?(0,7) }

  end


  def dup

    new_board = Board.new(false, true)

    pieces.each do |piece|

      piece.class.new(piece.color,new_board,piece.pos,piece.is_king?)
    end



    new_board
  end


  def empty?(pos)
    self[pos].nil?
  end

  def init_pieces
    @board.each_with_index do |row, i|
      row.each_with_index do |square, j|
        #p @board
        if j % 2 == 1 && (i == 5 || i == 7)
          Piece.new(:black,self,[i,j],false)
        elsif j % 2 == 0 && (i == 6)
          Piece.new(:black,self,[i,j],false)
        elsif j % 2 == 0 && (i == 0 || i == 2)
          Piece.new(:white,self,[i,j],false)
        elsif j % 2 == 1 && (i == 1)
          Piece.new(:white,self,[i,j],false)
        end
      end
    end
  end


  def render
    flip = 1
    print "   0 1 2 3 4 5 6 7"
    puts
    i = 0
    @board.each do |row|
      print i
      print " "
      i += 1
      row.each do |square|

        if flip == 1
          if square.nil?
            print "  "
            flip *= -1
          else
            print square.rep
            flip *= -1
          end
        else
          print "\u2591" * 2
          flip *= -1
        end

      end
      flip *= -1
      puts
    end
    nil
  end

end
