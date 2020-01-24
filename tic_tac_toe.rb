class TicTacToe
  def initialize
    @board = {
        "a1" => nil,
        "a2" => nil,
        "a3" => nil,
        "b1" => nil,
        "b2" => nil,
        "b3" => nil,
        "c1" => nil,
        "c2" => nil,
        "c3" => nil,
    }
    @winning_combinations =
        [
          %w(a1 a2 a3),
          %w(b1 b2 b3),
          %w(c1 c2 c3),
          %w(a1 b1 c1),
          %w(a2 b2 c2),
          %w(a3 b3 c3),
          %w(a1 b2 c3),
          %w(a3 b2 c1),
        ]
    @players = %w(X O)
  end

  def turn(player, slot)
    unless @board.key? slot
      p "#{slot} is not a valid position."
      self.turn(player, gets.chomp)
    end

    if @board[slot] != nil
      p "#{@board[slot]} is already in that position, choose another position."
      self.turn(player, gets.chomp)
    end

    @board[slot] = player
    show_board
  end

  def start
    p "who starts (X or O)?"
    player = gets.chomp.upcase
    unless @players.include? player
      p "try again."
      start
    end
    show_board
    p "#{player}, make your move"
    turn(player, gets.chomp)

    while board_has_slots?
      player_index = @players.index(player)
      player = @players[player_index - 1]
      p "#{player}, make your move"
      turn(player, gets.chomp)
      if winner?
        return p "#{player} wins!"
      end
    end

    p "The board is full! There is no winner"
  end

  def show_board
    puts "  1   2   3"
    puts "a #{@board['a1'] || " "} | #{@board['a2'] || " "} | #{@board['a3'] || " "} "
    puts " ---+---+---"
    puts "b #{@board['b1'] || " "} | #{@board['b2'] || " "} | #{@board['b3'] || " "} "
    puts " ---+---+---"
    puts "c #{@board['c1'] || " "} | #{@board['c2'] || " "} | #{@board['c3'] || " "} "
    puts "\n"
  end

  def winner?
    @winning_combinations.any? do |lines|
      !@board[lines[0]].nil? && @board[lines[0]] == @board[lines[1]] && @board[lines[1]] == @board[lines[2]]
    end
  end

  def board_has_slots?
    @board.values.any? { |x| x.nil? }
  end
end

game = TicTacToe.new
game.start