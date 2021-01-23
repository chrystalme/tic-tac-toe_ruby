class GameBoard
  attr_reader :slots

  WINNING_COMBINATION = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  def initialize
    @slots = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def show_board
    <<~HEREDOC
      \n
      \s#{slots[0]} | #{slots[1]} | #{slots[2]}
      ---|---|---
      \s#{slots[3]} | #{slots[4]} | #{slots[5]}
      ---|---|---
      \s#{slots[6]} | #{slots[7]} | #{slots[8]}
    HEREDOC
  end

  def update_board(move, symbol)
    @slots[move - 1] = symbol
  end

  # def move_valid?(move)
  #   @slots[move - 1] == move and @played.none?(move)
  # end

  def slots_full?
    @slots.all? { |slot| slot =~ /[^0-9]/ }
  end

  def game_done?
    WINNING_COMBINATION.any? or slots_full? 
  end
end
