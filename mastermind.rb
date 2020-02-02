class Game
  attr_writer :secret

  def start
    @secret = generate_code
    @board = {}
    puts "MASTERMIND"
    puts "guess a 4 number code with numbers between 1 - 6. you have 12 guesses!"
    puts "key:"
    puts "- wrong guess"
    puts "x right number, wrong place"
    puts "o right number, right place"
    puts "who would you like to plays as?"
    puts "a. codebreaker"
    puts "b. codemaker"
    if gets.chomp.downcase == 'a' || gets.chomp.downcase == 'codebreaker'
      return codebreaker_game
    end
    codemaker_game
  end

  def codebreaker_game
    puts "the computer has chosen a secret code"
    puts "make your first guess"

    while @board.count < 11
      if check?
        return p "You won!"
      end
      result = guess(normalize_code(gets.chomp))
      @board[@board.count + 1] = result
      show_board
    end
  end

  def codemaker_game
    puts "choose a secret code:"
    #  todo: validate code
    @secret = normalize_code(gets.chomp)
    @wrong_numbers = []
    puts "the computer will try to guess your code..."
    guess = computer_guess
    while @board.count < 11
      if check?
        return p "computer won!"
      end
      p guess
      result = guess(guess)
      @board[@board.count + 1] = result
      p result
      guess = computer_guess(result, guess)
      # show_board
    end
    p "You won! the computer could not crack the code."
  end

  def computer_guess(clues = [], prev_guess = [])
    return generate_code if clues.empty?

    new_guess = [0, 0, 0, 0]
    clues.each_with_index do |clue, idx|
      case clue
      when '-'
        @wrong_numbers.push prev_guess[idx]
      when 'o'
        new_guess[idx] = prev_guess[idx]
      else
        new_guess[idx] = (-clue).to_i
      end
    end

    new_guess = new_guess.each_with_index.map do |num, idx|
      next num if num > 0
      if num < 0
        next generate_number(@wrong_numbers + [-num])
      end
      generate_number(@wrong_numbers)
    end

    new_guess
  end

  private

  def generate_code
    4.times.map { generate_number }
  end

  def generate_number(omit = [])
    ([*1..6] - omit).sample
  end

  def normalize_code(code)
    if code.match(/[\s,]+/).nil?
      return code.split('').map(&:to_i)
    end
    code.split(/[\s,]+/).map(&:to_i)
  end

  def guess(code)
    code.each_with_index.map do |num, idx|
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
      winner = rows[1].all? do |column|
        column == "o"
      end
    end
    winner
  end
end

game = Game.new
game.start