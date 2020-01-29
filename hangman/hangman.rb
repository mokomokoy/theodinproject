require 'json'

class Game
  HANGMAN = [
    [
      " |‾‾‾|",
      "     |",
      "     |",
      "     |",
      "    /|",
      " ‾‾‾‾‾"
    ],
    [
      " |‾‾‾|",
      " o   |",
      "     |",
      "     |",
      "    /|",
      " ‾‾‾‾‾"
    ],
    [
      " |‾‾‾|",
      " o   |",
      " |   |",
      "     |",
      "    /|",
      " ‾‾‾‾‾"
    ],
    [
      " |‾‾‾|",
      " o   |",
      "/|   |",
      "     |",
      "    /|",
      " ‾‾‾‾‾"
    ],
    [
      " |‾‾‾|",
      " o   |",
      "/|\\  |",
      "     |",
      "    /|",
      " ‾‾‾‾‾"
    ],
    [
      " |‾‾‾|",
      " o   |",
      "/|\\  |",
      "/    |",
      "    /|",
      " ‾‾‾‾‾"
    ],
    [
      " |‾‾‾|",
      " o   |",
      "/|\\  |",
      "/ \\  |",
      "    /|",
      " ‾‾‾‾‾"
    ],
  ]
  SAVE_FILE = 'saves.json'

  def initialize
    @dictionary = []
    File.open("5desk.txt", "r") do |file|
      file.readlines.each { |line|
        @dictionary << line.chomp if line.length.between? 5, 12
      }
    end
    @word = @dictionary.sample.downcase
    @clue = @word.chars.map { "_" }
    @wrong_guesses = []
    @save_name = ''
  end

  def start
    intro
    puts "would you like to start with:"
    puts "(a) a new game"
    puts "(b) a saved game"
    game = gets.chomp
    if game == 'a'
      return play
    elsif game == 'b'
      puts "what is the name of your save?"
      @save_name = gets.chomp
      load_game(find_game(@save_name))
      play
    end
  end

  def play
    while @wrong_guesses.length < HANGMAN.length
      show_hangman
      return puts "You won! The word was \"#{@word}\"." if win?
      puts "\n\n" + @clue.join(" ")
      puts "\n\nchoose a letter:"
      string = gets.chomp.downcase.strip
      validate_guess(string)
    end
    show_hangman
    puts "you lost. The word was \"#{@word}\"."
  end

  def validate_guess(string)
    if string.empty?
      puts "invalid guess, try again"
      string = gets.chomp.downcase.strip
      return validate_guess(string)
    end

    if string == 'xxx'
      return save_and_quit
    end

    guess(string)
  end

  def guess(string)
    if string == @word
      return @clue = @word.split('')
    end

    string = string[0] #shorted guess to one character

    if (@wrong_guesses.include? string) || (@clue.include? string)
      return puts "you have already tried \"#{string}\""
    end

    if @word.include? string
      puts "it's a hit!"
      return @clue = @clue.each_with_index.map do |letter, index|
        next string if @word[index] == string
        letter
      end
    end

    puts "it's a miss!"
    @wrong_guesses << string
  end

  def win?
    @clue.all? do |letter|
      letter != '_'
    end
  end

  def save_and_quit
    if @save_name.empty?
      puts "you are about to save and quit. please give your save a name:"
      @save_name = gets.chomp.downcase
    end

    game = {
      "name" => @save_name,
      "wrong_guesses" => @wrong_guesses,
      "word" => @word,
      "clue" => @clue
    }

    if saves.any? { |save| save[:name] == @save_name }
      puts "your save \"#{@save_name}\" will be overridden"
      new_save = saves.map { |save|
        next game if save[:name] == @save_name
        save
      }
    else
      new_save = saves << game
    end

    File.open(SAVE_FILE, "w") do |f|
      f.write(new_save.to_json)
    end

    puts "your game has been saved. bye!"
    exit
  end

  def find_game(name)
    if saves.empty?
      puts "your game could not be found!"
    end

    games = saves.select do |game|
      game[:name] == name
    end

    if games.empty?
      puts "your game could not be found!"
      exit
    end

    games.first
  end

  def saves
    if !File.exists?(SAVE_FILE)
      File.open(SAVE_FILE, 'w') {|f| f.write("[]") }
    end

    JSON.parse(File.read(SAVE_FILE), :symbolize_names => true)
  end

  def load_game(game = {})
    @wrong_guesses = game[:wrong_guesses]
    @clue = game[:clue]
    @word = game[:word]
  end

  def show_hangman
    puts HANGMAN[@wrong_guesses.length - 1] if !@wrong_guesses.empty?
    puts "Misses: " + @wrong_guesses.join(",") if !@wrong_guesses.empty?
  end

  def intro
    puts "======================================================="
    puts "||               Welcome to Hangman!                 ||"
    puts "|| at each turn choose a letter to fill in the gaps. ||"
    puts "||         you have until the man is hanged!         ||"
    puts "||                                                   ||"
    puts "|| at any point your can type \"xxx\" to save and quit ||"
    puts "=======================================================\n\n"
  end
end

game = Game.new
game.start
