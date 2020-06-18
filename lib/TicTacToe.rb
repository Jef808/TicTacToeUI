class TicTacToe

  WIN_COMBINATIONS = [ # A Nested array comprising of all winning combinatinos.
    [0,1,2], [3,4,5], [6,7,8], # The rows
    [0,3,6], [1,4,7], [2,5,8],# The columns
    [0,4,8], [2,4,6] # The diagonals
  ]

  attr_accessor :board

  def initialize(board = Array.new(9," "))
    @board = board
  end

  def won?
    WIN_COMBINATIONS.each do |pos_ary|
      sequence = @board.values_at(*pos_ary)
     return pos_ary if [["X"], ["O"]].any? { |c| sequence.uniq == c }
      end
    nil
  end

  def display_board
    ret = []
    @board.each_slice(3) do |i, j, k| ret << " #{i} | #{j} | #{k} "
    end
    [1,3].each{ |i| ret.insert(i, "-----------") }
    puts ret
  end

  def input_to_index(_inp)
    _inp =~ /[1-9]/ ? _inp.to_i - 1 : nil
  end

  def position_taken?(_index)
    !(@board[_index] == " ")
  end

  def valid_move?(_index)
    ((0..8)===_index)&&!(position_taken? _index)
  end

  def turn_count
    9 - @board.count(" ")
  end

  def current_player
    self.turn_count.even? ? "X" : "O"
  end

  def move(_index)
    token = self.current_player
    @board[_index] = token if valid_move?(_index)
    return self
  end

  def full?
    !(@board.include? " ")
  end

  def draw?
    self.full? && !self.won?
  end

  def over?
    self.won? || self.draw?
  end

  def possible_moves
    @board.map.with_index{ |square, ind| ind if square == " "}.keep_if{ |square| square.is_a? Integer }
  end

  def winner
    begin
      @board[self.won?[0]]
    rescue NoMethodError
      nil
    end
  end

  def play_turn
      puts "Please select a square by entering 1-9, 1 for the top left and 9 for the bottom right:"
      loop do
      if _index = input_to_index(gets)
        move(_index)
        display_board
        break
      else
        puts "Invalid square, please try again."
      end # if/else
      end # loop
    end

  def play
    until self.over? do
      self.play_turn
    end
    if self.won?
      puts "The #{self.winner} player wins!"
    elsif self.draw?
      puts "The game was a draw."
    end
  end # play

end # TicTacToe
