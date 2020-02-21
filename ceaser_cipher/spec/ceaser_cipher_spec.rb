require './lib/ceaser_cipher'

RSpec.describe do
  describe "ceaser_cipher" do
    it "returns a given string shifted by 3 characters" do
      expect(ceaser_cipher('shift a String', 3)).to eql('vkliw d Vwulqj')
    end

    it "returns a given string shifted by 5 characters and maintains case and grammar" do
      expect(ceaser_cipher('The method is named after Julius Caesar, who used it in his private correspondence.', 5))
        .to eql('Ymj rjymti nx sfrji fkyjw Ozqnzx Hfjxfw, bmt zxji ny ns mnx uwnafyj htwwjxutsijshj.')
    end
  end
end