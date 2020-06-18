require_relative '../lib/AI.rb'

ary1 = ["X", " ", "O", " ", "X", "O", " ", " ", "O"]

describe './lib/AI.rb' do

  describe '#switch_player' do
    it "switches the X to O and vice versa" do
      expect(switch_player("X")).to eq "O"
      expect(switch_player("O")).to eq "X"
    end
  end

  describe '#eval_gamestate' do

    it "First checks if the state is won" do
      gamestate = TicTacToe.new(["X", "O", " ", "O ", "X", " ", " ", " ", "X"])
      expect(eval_gamestate(gamestate, "X")).to eq 10
      expect(eval_gamestate(gamestate, "O")).to eq -10
    end

    it "next checks if the gamestate is drawn" do
      drawn_ary = %w(X X O O O X X O X)
      gamestate = TicTacToe.new(drawn_ary)
      ["X", "O"].each{ |player| expect(eval_gamestate(gamestate, player)).to eq 0 }
    end

    it "otherwise considers every moves " do
      ary = ["X", "X", "O", "O", "O", " ", "X", " ", "X"]
      cur_game = TicTacToe.new(ary)
      expect(eval_gamestate(cur_game, "X")).to eq -10
    end
  end #eval_move
end #AI.rb
