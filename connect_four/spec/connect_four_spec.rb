require './lib/connect_four'

RSpec.describe do
  describe "#turn" do
    game = ConnectFour.new
    it "allows the player to drop a disc in to the board" do
      game.turn('yellow', 6)
      expect(game.board[6]).to contain('yellow')
    end
    it "prevents the player from making a turn if the column is invalid" do

    end

    it "prevents the player from making a turn if the column is full" do

    end
  end

  describe "#winner?" do
    it "checks the board for a winning combination" do

    end
  end

  describe "#column_has_slots?" do
    it "checks if the given column has available slots" do

    end
  end

  describe "#board_has_slots?" do
    it "checks if the board has empty slots" do

    end
  end
end