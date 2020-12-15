# frozen_string_literal: true
# spec testing script for tic_tac_toe
require_relative "../lib/game.rb"

# Here is a summary of what should be tested
# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method


# 1. Arrange -> set up the test (examples: initializing objects, let
#               variables, updating values of instance variables).
# 2. Act ->     execute the logic to test (example: calling a method to run).
# 3. Assert ->  expect the results of arrange & act.

describe Game do
  describe '#move' do # Command
    subject(:move_game) { described_class.new }
    context 'when player character is X' do
      it 'adds X to @game_state' do
        character = 'X'
        position = 1
        move_game.move(position, character)
        expect(move_game.game_state).to include('X')
      end
      it 'will not accept numbers not in the array' do
        character = 'X'
        wrong_position = 11
        move_game.move(wrong_position, character)
        expect(move_game.game_state).not_to include('X')
      end
    end
  end

  describe '#prompt_player' do # looping script
    subject(:prompt_game) { described_class.new(['X', 'O', 3, 4, 5, 6, 7, 8, 9]) }
    context 'when passed a valid position' do
      before do
        allow(prompt_game).to receive(:gets).and_return('3')
      end
      it 'stops loop' do
        expect(prompt_game).to receive(:puts).once
        prompt_game.prompt_player('X')
      end
      it 'returns valid position' do
        value = prompt_game.prompt_player('X')
        expect(value).to eq(3)
      end
    end
    context 'when passed an invalid, then valid position' do
      before do
        allow(prompt_game).to receive(:gets).and_return('1', '3')
      end
      it 'runs loop twice then stops' do
        expect(prompt_game).to receive(:puts).twice
        prompt_game.prompt_player('X')
      end
      it 'returns second valid value' do
        value = prompt_game.prompt_player('X')
        expect(value).to eq(3)
      end
    end
  end

  describe '#turn' do
    subject(:turn_game) { described_class.new }

    context 'when turn is called' do

      before do
        allow(turn_game).to receive(:prompt_player).and_return(1)
      end

      it 'calls print_board' do
        expect(turn_game).to receive(:print_board).once
        turn_game.turn('X')
      end

      it 'calls move' do
        expect(turn_game).to receive(:move).once
        turn_game.turn('X')
      end
    end
  end

  describe '#check_win?' do
    subject(:win_game) { described_class.new }
    context 'When passed a not winning board' do
      it 'returns false' do
        invalid_board = ['X', 2, 3, 4, 5, 6, 7, 8]
        result = win_game.check_win?(invalid_board)
        expect(result).to be false
      end
    end

    context 'When passed a winning board' do
      it 'returns true for horizontal wins' do
        valid_board = ['X', 'X', 'X', 4, 5, 6, 7, 8, 9]
        horizontal_win = described_class.new(valid_board)
        result = horizontal_win.check_win?('X')
        expect(result).to be true
      end
      it 'returns true for vertical wins' do
        valid_board = ['X', 2, 3, 'X', 5, 6, 'X', 8, 9]
        vertical_win = described_class.new(valid_board)
        result = vertical_win.check_win?('X')
        expect(result).to be true
      end
      it 'returns true for diagnol wins' do
        valid_board = ['X', 2, 3, 4, 'X', 6, 7, 8, 'X']
        diagnol_win = described_class.new(valid_board)
        result = diagnol_win.check_win?('X')
        expect(result).to be true
      end
    end
  end

  describe '#check_draw?' do
    context 'when passed an incomplete board' do
      it 'returns false' do
        open_board = [1, 2, 3, 4, 5, 6, 7, 8]
        open_game = described_class.new(open_board)
        expect(open_game.check_draw?).to be false
      end
    end

    context 'when passed a full winning board' do
      it 'returns false' do
        winning_board = ['X', 'X', 'X',
                         'O', 'X', 'O',
                         'O', 'O', 'X' ]
        x_win = described_class.new(winning_board)
        expect(x_win.check_draw?).to be false
      end
    end

    context 'when passed a not-full winning board' do
      it 'returns false' do
        winning_board = ['X', 'X', 'X',
                        'O', 'X', 'O',
                        'O', 'O',  9 ]
        x_win = described_class.new(winning_board)
        expect(x_win.check_draw?).to be false
      end
    end

    context 'when passed a drawing board' do
      it 'returns true' do
        drawing_board = ['O', 'X', 'X',
                         'X', 'X', 'O',
                         'O', 'O', 'X' ]
        no_win = described_class.new(drawing_board)
        expect(no_win.check_draw?).to be true
      end
    end
  end
end