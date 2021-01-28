require '../spec/spec_helper'
require_relative '../lib/game_board'
describe GameBoard do
  subject(:board) { described_class.new }

  describe '#update_board' do
    context 'when the board is new' do
      it 'updates the board @slots[index]' do
        player_move = 5
        player_symbol = 'X'
        board.update_board(player_move, player_symbol)
        updated_board = board.slots
        updated_index_five = [1, 2, 3, 4, 'X', 6, 7, 8, 9]
        expect(updated_board).to eq(updated_index_five)
      end
    end

    context 'when the board contains some moves' do
      before do
        board.instance_variable_set(:@slots, ['O', 2, 3, 'X', 'X', 6, 7, 'X', 9])
      end

      it 'updates the board @slots[index]' do
        player_move = 2
        player_symbol = 'O'
        board.update_board(player_move, player_symbol)
        updated_board = board.slots
        updated_index_two = ['O', 'O', 3, 'X', 'X', 6, 7, 'X', 9]
        expect(updated_board).to eq(updated_index_two)
      end
    end
  end

  describe '#move_valid?' do
    context 'when the board is new' do
      it 'is a valid move' do
        player_move = board.move_valid?(4)
        expect(player_move).to be true
      end
    end

    context 'when the board is new' do
      it 'is not a valid move' do
        player_move = board.move_valid?(11)
        expect(player_move).to be false
      end
    end
  end

  describe '#win?(move)' do
    before do
      board.instance_variable_set(:@slots, ['O', 2, 3, 'X', 'X', 6, 7, 'O', 9])
    end
    context 'When to call it a win' do
      it 'Identifies the scenarios of win in the game' do
        player_move = 6
        player_symbol = 'X'
        board.update_board(player_move, player_symbol)
        updated_board = board.slots
        win_board = ['O', 2, 3, 'X', 'X', 'X', 7, 'O', 9]
        expect(updated_board).to eq(win_board)
      end
    end

    context 'When not to call it a win' do
      it 'Identifies the scenarios of not win in the game' do
        player_move = 9
        player_symbol = 'X'
        board.update_board(player_move, player_symbol)
        updated_board = board.slots
        win_board = ['O', 2, 3, 'X', 'X', 'X', 7, 'O', 9]
        expect(updated_board).to_not eq(win_board)
      end
    end
  end

  describe 'slots_full?' do
    before do
      board.instance_variable_set(:@slots, %w[O X O O X O X O X])
    end
    it 'Returns true if slots is full otherwise returns false' do
      full_slot = board.slots_full?
      expect(full_slot).to be true
    end
  end
end
