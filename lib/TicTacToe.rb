class TicTacToe

  WIN_COMBINATIONS = [ # A Nested array comprising of all winning combinatinos.
    [0,1,2], [3,4,5], [6,7,8], # The rows
    [0,3,6], [1,4,7], [2,5,8],# The columns
    [0,4,8], [2,4,6] # The diagonals
  ]

  attr_accessor :board

  def initialize(bord = nil)
    @board = board || Array.new(9, " ")
  end

  def won?
    WIN_COMBINATIONS.each do |pos_ary|
      sequence = @board.values_at(*pos_ary)
      return sequence if [["X"], ["O"]].any? { |c| sequence.uniq == c }
    end
  end

  def display_board
    ret = []
    @board.each_slice(3) do |i, j, k|
      ret << " #{i} | #{j} | #{k} " << "-"*11
    end
    ret.delete_at(-1)
    puts ret
  end

  def input_to_index(inp)
    inp.to_i - 1
  end

  def move

  end

  def eval

  end

end
