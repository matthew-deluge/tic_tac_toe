# game.rb
# simple command line tic tac toe game for two human players

# The main game class for tic tac toe
class Game
  attr_reader :game_state

  WIN_CONDITIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # horizontal wins
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # vertical wins
    [1, 5, 9], [3, 5, 7]             # diaganol wins
  ]

  def initialize(game_state = [1, 2, 3, 4, 5, 6, 7, 8, 9])
    #puts "Let's play\nTIC\nTAC\nTOE!!!!!"
    @game_state = game_state
  end
 
  def move(number, player_character)
    @game_state[number - 1] = player_character if @game_state.include?(number)
  end

  def prompt_player(player_character)
    player_move = ""
    until @game_state.include?(player_move)
      puts "#{player_character}'s turn. Put the number of the space you want to go!"
      player_move = gets.chomp.to_i
    end
    player_move
  end

  def turn(player_character)
    print_board
    position = prompt_player(player_character)
    move(position, player_character)
  end

  def check_win?(player_character)
    check_array = []
    @game_state.each_with_index do |state, index|
      check_array.push(index + 1) if state == player_character
    end
    WIN_CONDITIONS.each do |condition|
      return true if (condition - check_array) == []
    end
    false
  end

  def check_draw?
    if @game_state.all? { |a| a.is_a?(String) }
      !check_win?('X')&&!check_win?('O')
    else
      false
    end
  end

  def play
    x_turn = true
    while !check_win?("X") && !check_win?("O")&&!check_draw?
      if x_turn
        turn("X")
        x_turn = false
      else 
        turn("O")
        x_turn = true
      end
    end
    print_board
    display_result
  end

  private

  def display_result 
    result = ''
    if check_draw?
      result = "Draw!"
    else
      result = check_win?('X') ? 'Great job, X wins!' : 'Great Game, O wins!'
    end
    puts result
  end

  def print_board
    #puts "\e[H\e[2J"
    print " #{@game_state[0..2].join(' | ')}"
    print "\n-----------\n"
    print " #{@game_state[3..5].join(' | ')}"
    print "\n-----------\n"
    print " #{@game_state[6..8].join(' | ')}"
    print "\n\n"
  end

end



