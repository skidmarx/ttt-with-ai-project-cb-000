class Game

attr_accessor :player_1, :player_2, :board

def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new )

  @player_1 = player_1
  @player_2 = player_2
  @board = board
end



WIN_COMBINATIONS = [

  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def current_player
  @board.turn_count % 2 == 0 ? @player_1 : player_2
end

def won?
  WIN_COMBINATIONS.detect do |win_combo|
    @board.cells[win_combo[0]] == @board.cells[win_combo[1]] && @board.cells[win_combo[1]] == @board.cells[win_combo[2]] && @board.taken?(win_combo[0] + 1)
  end
end

def draw?
  @board.full? && !won? ? true : false
end

def over?
  won? || draw?
end

def winner
  if !won?
    nil
  elsif @board.cells[won?[0]] == "X"
    "X"
  else @board.cells[won?[0]] == "O"
    "O"
  end
end

def turn
  player = current_player
  current_move = player.move(@board)
  if !@board.valid_move?(current_move)
    turn
  else
    @board.display
    @board.update(current_move, player)
  end
end

def play
  until over?
    turn
  end
  if draw?
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner}!"
  end
end
end
