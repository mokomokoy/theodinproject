require './lib/tic_tac_toe'
require 'stringio'

def capture_stdout(&blk)
  old = $stdout
  $stdout = fake = StringIO.new
  blk.call
  fake.string
ensure
  $stdout = old
end

def capture_input
  $stdin.gets.chomp
end

RSpec.describe do
  describe "#turn" do
    game = TicTacToe.new
    it "allows the player to make a mark on a position on the board" do
      game.turn('x', 'a1')
      expect(game.board['a1']).to eql('x')
    end

    it "prevents the player from making a turn if the position is invalid" do
      printed = capture_stdout do
        $stdin = StringIO.new('b1')
        game.turn('x', 'zz')
      end
      expect(printed).to include('zz is not a valid position.')
    end

    it "prevents the player from making a turn if the position is taken" do
      printed = capture_stdout do
        $stdin = StringIO.new('c1')
        game.turn('x', 'a1')
      end
      expect(printed).to include('x is already in that position, choose another position.')
    end
  end

  describe "#show_board" do
    game = TicTacToe.new({ 'a1' => 'x', 'b1' => 'x', 'c1' => 'x' })
    printed = capture_stdout do
      game.show_board
    end
    it "prints the board" do
      expect(printed.gsub(' ', '')).to eql('123
ax||
---+---+---
bx||
---+---+---
cx||

')
    end
  end
  describe "#winner?" do
    it "checks the board for a winning combination" do
      game = TicTacToe.new({ 'a1' => 'x', 'b1' => 'x', 'c1' => 'x' })
      expect(game.winner?).to eql(true)
      game2 = TicTacToe.new({ 'a1' => 'x', 'b1' => 'x', 'c1' => 'o' })
      expect(game2.winner?).to eql(false)
    end
  end

  describe "#board_has_slots?" do
    it "checks the board for a empty slots" do
      game = TicTacToe.new({ 'a1' => 'x', 'b1' => 'x', 'c1' => 'x' })
      expect(game.board_has_slots?).to eql(true)
      game2 = TicTacToe.new({
                              'a1' => 'x', 'b1' => 'x', 'c1' => 'o',
                              'a2' => 'o', 'b2' => 'o', 'c2' => 'x',
                              'a3' => 'x', 'b3' => 'x', 'c3' => 'o' })
      expect(game2.board_has_slots?).to eql(false)
    end
  end
end