# tic_tac_toe.rb
# simple command line tic tac toe game for two human players

class Game 
  WIN_CONDITIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # horizontal wins
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # vertical wins
    [1, 5, 9], [3, 5, 7]             # diaganol wins
  ]
  def initialize 
    puts "Let's play\nTIC\nTAC\nTOE!!!!!"
    @game_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def print_board # prints board with symbols and spacing
    print " "+@game_state[0..2].join(" | ")
    print "\n-----------\n"
    print " "+@game_state[3..5].join(" | ")
    print "\n-----------\n"
    print " "+@game_state[6..8].join(" | ")
    print "\n\n"
  end

  def move(number, player_character) # basic move method, assumes only correct moves will be passed
    @game_state[number - 1] = player_character
    if check_win(player_character)
      puts "#{player_character} wins!"
    end
  end

  def prompt_player(player_character) # method to get a move from the player, will only move forward if move is on board
    print_board
    player_move = ""
    until @game_state.include?(player_move)
      puts "#{player_character}'s turn. Put the number of the space you want to go!"
      player_move = gets.chomp.to_i
    end
    move(player_move, player_character)
  end

  def check_win(player_character) # checks to see if the win conditions are met
    check_array = []
    @game_state.each_with_index do |state, index|
      if state == player_character
        check_array.push(index + 1)
      end
    end
    WIN_CONDITIONS.each do |condition|
      if (condition - check_array) == []
        return true
      end
    end
    return false
  end

  def check_draw # checks if there are any legal moves left
    state = true
    @game_state.each {|spot| state = false if spot.is_a? Numeric}
    return state
  end

  def display_result #method that displays the winner (or draw)
    result = ""
    if !check_draw
      result =  check_win("X") ? "Great job, X wins!" : "Great Game, O wins!"
    else
      result = "Draw!"
    end
    return result
  end

  def play # main game loop
    x_turn = true
    while !check_win("X") && !check_win("O")&&!check_draw # main game loop
      if x_turn
        prompt_player("X")
        x_turn = false
      else 
        prompt_player("O")
        x_turn = true
      end
    end
    print_board
    puts display_result
  end
end

game = Game.new
game.play

