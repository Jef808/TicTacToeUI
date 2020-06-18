# To set tests for our helper methods
require_relative '../lib/TicTacToe.rb'

describe './lib/TicTacToe.rb' do
  describe TicTacToe do

  ary0 = Array.new(9){" "}
  ary1 = ["X", " ", "O", " ", "X", "O", " ", " ", "O"]

    describe '#initialize' do
      it "simply stores data as an Array of length 9, defaulting to blank spaces" do
        game = TicTacToe.new
        expect(game.board).to eq([" "]*9)
      end
    end

    describe '#won?' do
      it "returns the winning combo of indices if there is a win" do
        board = ["X", "O", "X", "O", "X", "O", "O", "X", "X"]
        game = TicTacToe.new(board)

        expect(game.won?).to contain_exactly(0,4,8)
      end

      it "is false if game is over but it is a draw" do
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game = TicTacToe.new(board)

        expect(game.won?).to be_falsey
      end
    end # won?

    describe '#display_board' do
      it "prints any board into a nice 3x3 grid" do
        board = ["X", "X", "X", "X", "O", "O", "X", "O", "O"]
        game = TicTacToe.new(board)

        output = capture_puts{ game.display_board }

        expect(output).to include(" X | X | X ")
        expect(output).to include("-----------")
        expect(output).to  include(" X | O | O ")
        expect(output).to  include("-----------")
        expect(output).to  include(" X | O | O ")

        board = ["X", " ", "X", "O", "X", " ", "O", "X", "O"]
        game = TicTacToe.new(board)

        output = capture_puts { game.display_board }

        expect(output).to include(" X |   | X ")
        expect(output).to include("-----------")
        expect(output).to  include(" O | X |   ")
        expect(output).to  include("-----------")
        expect(output).to  include(" O | X | O ")

      end
    end

    describe '#position_taken?' do
      it "checks if given square is empty" do
        board = ["X", " ", " ", " ", " ", " ", " ", " ", "O"]
        game = TicTacToe.new(board)

        expect([0,1,4,8].map{ |_index| game.position_taken?(_index) }).to eq([true, false, false, true])
      end
    end

    describe '#valid_move?' do
      it "checks if position is taken and if index is within 0 and 8" do
        board = [" ", " ", " ", "X", " ", " ", " ", " ", " ",]
        game = TicTacToe.new(board)

        expect(game.valid_move? (2)).to be_truthy
        expect(game.valid_move? (3)).to be_falsey
        expect(game.valid_move? (11)).to be_falsey
      end
    end

   describe '#turn_count' do
     it "counts the number of turns that has been played by looking at how many empty squares are left." do
       board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
       game = TicTacToe.new(board)

       expect(game.turn_count).to eq 3

       board = ["O", " ", "O", " ", "X", " ", " ", " ", "X"]
       game = TicTacToe.new(board)

       expect(game.turn_count).to eq 4
     end
   end

   describe '#current_player' do
     it "tells which player's turn (X or O) it is to play by looking at #turn_count" do
       board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
       game = TicTacToe.new(board)

       expect(game.current_player).to eq "O"

       board = ["O", " ", " ", " ", "X", " ", " ", " ", " "]
       game = TicTacToe.new(board)

       expect(game.current_player).to eq "X"
     end
   end

   describe '#move' do
     it "checks if the move index is valid via #valid_move? and if so (using #current_player) places the right token (X or O) there" do
       game = TicTacToe.new

       expect(game).to receive(:valid_move?).and_return(true, true, false)
       expect(game).to receive(:current_player).and_return("X", "O", "X")
       game.move(0)
       game.move(4)
       game.move(4)

       expect(game.board).to eq(["X", " ", " ", " ", "O", " ", " ", " ", " "])
     end

    it "it returns self so the method can be chained" do
      game = TicTacToe.new
      after_move = game.move(0)

      expect(after_move).to eq game
    end
  end #move

  describe '#full?' do
    it "returns true iff the board has no more empty squares" do
      board = ["X", "X", "O", "X", "O", "X", "O", "X", "O"]
      game = TicTacToe.new(board)

      expect(game.full?).to be true

      board = [" ", "X", "O", "X", "O", "X", "O", "X", "O"]
      game = TicTacToe.new(board)

      expect(game.full?).to be_falsey
    end
  end

  describe '#draw?' do
    it "returns true for a draw" do
      board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
      game = TicTacToe.new(board)

      expect(game.draw?).to be_truthy
    end

    it "returns false for a won game or a game still in progress" do
      board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
      game = TicTacToe.new(board)

      expect(game.draw?).to be_falsey

      board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
      game = TicTacToe.new(board)

      expect(game.draw?).to be_falsey
    end
  end

  describe '#over?' do
    it "returns true for a draw or a won game" do
      board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
      game = TicTacToe.new(board)

      expect(game.over?).to be_truthy

      board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
      game = TicTacToe.new(board)

      expect(game.over?).to be_truthy
  end

  it "returns false for a game still in progress" do
    board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
    game = TicTacToe.new(board)

    expect(game.draw?).to be_falsey
  end
end

describe '#winner' do
  it "returns 'X' when X has won" do
    board = ["X", "O", "O", " ", "X", " ", " ", " ", "X"]
    game = TicTacToe.new(board)

    expect(game.winner).to eq "X"
  end

  it "returns 'O' when O has won" do
    board = ["X", "O", "X", " ", "O", " ", " ", "O", "X"]
    game = TicTacToe.new(board)

    expect(game.winner).to eq "O"
end

  it "returns nil when there is no winner" do
    board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
    game = TicTacToe.new(board)

    expect(game.winner).to be nil
  end
end

  describe '#input_to_index' do
    let(:game) { TicTacToe.new }
    it "converts the user (string) input (from 1 to 9) to the 'starting-at-0' Array index integer (just does minus 1)" do
      expect(game.input_to_index("1")).to be 0
    end

    it "returns nil if user input was not a string between '1' and '9'" do
      expect(game.input_to_index("invalid")).to be nil
    end
  end

  describe '#play_turn' do
    let(:game) { TicTacToe.new }

    it "receives user input via gets" do
      allow($stdout).to receive(:puts)
      expect(game).to receive (:gets){"1"}

      game.play_turn
    end

    it "then calls #input_to_index and sends this to #move then #display_board" do
      allow($stdout).to receive(:puts)
      expect(game).to receive(:gets).and_return("5\n")
      expect(game).to receive(:input_to_index).and_return(4)
      expect(game).to receive(:move).and_return(TicTacToe.new([" ", " ", " ", " ", "X", " ", " ", " ", " ", " "]))
      expect(game).to receive(:display_board)

      game.play_turn
    end

  it "Asks for input again in case the move was invalidated by #input_to_index" do
    allow($stdout).to receive(:puts)

    expect(game).to receive(:gets).and_return("invalid")
    expect(game).to receive(:gets).and_return("1")

    game.play_turn
  end
end

  describe '#possible_moves' do
    it "returns the array of indices of empty squares on the board" do
      board = ["X", "X", "O", " ", " ", "X", "O", " ", " "]
      game = TicTacToe.new(board)

      expect(game.possible_moves).to eq([3,4,7,8])

      board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
      game = TicTacToe.new(board)

      expect(game.possible_moves).to eq([])
    end
  end

  end
end
