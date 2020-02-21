require 'matrix'
require 'colorize'

class ConnectFour
  attr_reader :board

  def initialize(board = {})
    @board = [
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil]
    ]
    @players = ['yellow', 'red']
  end

  def turn(player, column)
    column = column.to_i
    if @board.length < column
      p "The column is invalid, choose another column"
      turn(player, gets.chomp)
    end
    # column is invalid
    @board.each_with_index do |row, index|
      if index == column - 1
        # column is full
        if row.none? { |e| e.nil? }
          p "The column is full, choose another column"
          turn(player, gets.chomp)
        end
        row.each_with_index { |slot, slot_index|
          if slot.nil?
            @board[index][slot_index] = player
            break
          end
        }
      end
    end
    # p @board
  end

  # def winner?
  #   matrix_columns = Matrix.rows(@board)
  #   matrix_rows = Matrix.columns(@board)
  #   winner = false
  #
  #   matrix_columns.to_a.each do |column|
  #     concurrent_items = 1
  #     column.reduce do |sum, slot|
  #       if concurrent_items == 4
  #         p "column win"
  #         return true
  #       end
  #       if sum
  #         if sum == slot
  #           concurrent_items += 1
  #         end
  #       end
  #       slot
  #     end
  #   end
  #   matrix_rows.to_a.each do |row|
  #     concurrent_items = 1
  #     row.reduce do |sum, slot|
  #       if concurrent_items == 4
  #         p "row win"
  #         return true
  #       end
  #       if sum
  #         if sum == slot
  #           concurrent_items += 1
  #         end
  #       end
  #       slot
  #     end
  #   end
  #
  #   @board
  #
  #   winner
  # end

  def winner?(player)
    (0..6).each do |i|
      (0..5).each do |j|
        if @board[i][j] == player
          if j < 3 and (1..3).all? { |x| @board[i][j + x] == player }
            return true
          elsif i < 4 and (1..3).all? { |x| @board[i + x][j] == player }
            return true
          elsif (i < 4 and j < 3) and (1..3).all? { |x| @board[i + x][j + x] == player }
            return true
          elsif (i < 4 and j > 2) and (1..3).all? { |x| @board[i + x][j - x] == player }
            return true
          end
        end
      end
    end
    false
  end

  def show_board
    print "   1     2     3     4     5     6     7"
    Matrix.columns(@board).to_a.reverse.each do |i|
      print "\n"
      @draw = "+-----+-----+-----+-----+-----+-----+-----+"
      puts @draw
      i.each do |n|
        piece = n == 'yellow' ? "●".yellow : (n == 'red' ? "●".red : ' ')
        print "|  #{piece}  "
      end
      print "|"
    end
    print "\n"
    print @draw
  end
end

game = ConnectFour.new
# game.turn('red', 1)
# game.turn('yellow', 1)
# game.turn('yellow', 2)
# game.turn('red', 2)
# game.turn('red', 2)
# game.turn('red', 2)
# game.turn('red', 3)
# game.turn('red', 3)
# game.turn('yellow', 3)
# game.turn('yellow', 4)
# game.turn('red', 4)
# game.turn('red', 4)
# game.turn('yellow', 4)
# game.turn('yellow', 5)
# game.turn('yellow', 5)
# game.turn('red', 5)
# game.turn('red', 5)
# game.turn('yellow', 5)
# game.turn('yellow', 6)
# game.turn('yellow', 6)
game.turn('red', 6)
game.turn('red', 6)

game.show_board

p game.winner?('yellow')
p game.winner?('red')