require_relative './TicTacToe.rb'

def switch_player(player)
  player == "X"? "O" : "X"
end

# player is the AI, he is trying to maximize his score.
def eval_gamestate(gamestate, player)
  if gamestate.won?
    return (gamestate.winner == player)? 10 : -10
  elsif gamestate.draw?
    return 0
  else
    cur_player = gamestate.current_player
    _op = (cur_player == player)? :max : :min
    gamestate.possible_moves.map{ |square| gamestate.move(square, player_token = cur_player) }.map{ |next_state| eval_gamestate(next_state, other_player(player))}.send(_op)
  end
end
