# tic_tac_toe.rb

class Game # the tic_tac_toe game
  WIN_CONDITIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # horizontal wins
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # vertical wins
    [1, 5, 9], [3, 5, 7]             # diagnol wins
  ]
  def initialize #(player_one, player_two)
    #@player_one = player_one
    #@player_two = player_two
    @game_state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def print_board
    @game_state[0..2].each { |element| print element }
    print "\n---\n"
    @game_state[3..5].each { |element| print element }
    print "\n---\n"
    @game_state[6..8].each { |element| print element }
    print "\n---\n"
  end

  def move(number, player_character)
    if @game_state.include?(number) 
      @game_state[number - 1] = player_character
    else
      puts "Not a legal move"
    end
    if check_win(player_character)
      puts "#{player_character} wins!"
    end
  end

  def check_win(player_character)
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

  def prompt_player(player_character)
    print_board
    player_move = ""
    unless @game_state.include?(player_move)
      puts "Put the number of the space you want to go!"
      player_move = gets.chomp.to_i
    end
    move(player_move, player_character)
  end

  def play 
    puts "Let's play tic tac toe!"
    x_turn = true
    while !check_win("X") && !check_win("O") # main game loop
      if x_turn
        prompt_player("X")
        x_turn = false
      else 
        prompt_player("O")
        x_turn = true
      end
    end
    puts "Game Over!"
  end
end

game = Game.new
game.play

