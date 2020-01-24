class Game
  def initialize
    @secret = 4.times.map { rand(1..6) }
    p @secret
    @board = {}
  end

  def start
    puts "MASTERMIND"
    puts "guess a 4 number sequence with numbers between 1 - 6. you have 12 turns!"
    puts "key:"
    puts "- wrong guess"
    puts "x right number, wrong place"
    puts "o right number, right place"
    puts "make your first guess"

    while @board.count < 11
      if check?
        return p "You won!"
      end
      result = guess
      @board[@board.count + 1] = result
      show_board
    end
  end

  def guess
    guess = gets.chomp.split(',').map(&:to_i)
    guess.each_with_index.map do |num, idx|
      next "o" if num == @secret[idx]
      next "x" if @secret.include? num
      "-"
    end
  end

  def show_board
    @board.each do |rows|
      p rows
    end
  end

  def check?
    winner = false
    @board.each_with_index do |rows|
      winner = rows[1].all? { |column|
        column == "o"
      }
    end
    winner
  end
end

game = Game.new
game.start