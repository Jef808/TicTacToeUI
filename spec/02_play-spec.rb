#  To test our main #play method
require_relative '../lib/TicTacToe.rb'

describe './lib/TicTacToe.rb' do
  describe TicTacToe do
    describe '#play' do

      let(:game) { TicTacToe.new }

      it "asks for players input on a new turn" do
        allow($stdout).to receive (:puts)
        allow(game).to receive(:over?).and_return(false, true)

        expect(game).to receive(:gets).at_least(:once).and_return("1")

        game.play
      end

      it "checks if the game is over after every turn" do
        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1", "2", "3")

        expect(game).to receive(:over?).at_least(:twice).and_return(false, false, true)

        game.play
      end

      it "plays the first turn of the game" do
          allow($stdout).to receive(:puts)
          allow(game).to receive(:gets).and_return("1")

         allow(game).to receive(:over?).and_return(false, true)

         game.play
         board_after_first_turn = game.board
         expect(board_after_first_turn).to match_array(["X", " ", " ", " ", " ", " ", " ", " ", " "])
      end

      it "plays the first few turns of the game" do
        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1", "2", "3")
        allow(game).to receive(:over?).and_return(false, false, false, true)

        game.play

        board_after_three_turn = game.board
        expect(board_after_three_turn).to eq(["X", "O", "X", " ", " ", " ", " ", " ", " "])
      end

      it "checks if the game is won after every turn then outputs who wins" do
        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1", "3", "4", "6", "7")

        expect(game).to receive(:won?).at_least(4).times.and_return(false, false, false, false, true)
        expect(game).to receive(:winner).and_return("X")
        expect($stdout).to receive(:puts).with("The X player wins!")

        game.play
      end

      it "stops playing if someone has won" do
        game = TicTacToe.new(["X", "X", "X", " ", " ", " ", " ", " ", " "])
        allow($stdout).to receive(:puts)

        expect(game).to_not receive(:play_turn)

        game.play
      end

      it "stops playing if game is a draw and outputs that it's a draw" do
        game = TicTacToe.new(["X", "O", "X", "O", "X", "X", "O", "X", "O"])

        expect(game).to_not receive(:play_turn)
        expect($stdout).to receive(:puts).with("The game was a draw.")

        game.play
      end

    end
  end
end
