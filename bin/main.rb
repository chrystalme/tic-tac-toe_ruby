#!/usr/bin/env ruby

require_relative '../lib/game_board'
require_relative '../lib/player'

class Game < GameBoard
  attr_reader :slot, :player1, :player2, :curr_player

  WINNING_COMBINATION = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

  def initialize()
    super
    @played = []
    # @player2 = player2
    # @curr_player = nil
  end

  # Introduction to our game and how to play
  def instructions
    puts <<~HEREDOC
      *****************************************************************
      *****************************************************************
      *********       WELCOME TO TIC-TAC-TOE            ***************
      *********                                         ***************
      *********     You play by putting X or O on       ***************
      *********     one of the following spaces 1-9     ***************
      *********                                         ***************
      *********               1 | 2 | 3                 ***************
      *********              --- --- ---                ***************
      *********               4 | 5 | 6                 ***************
      *********              --- --- ---                ***************
      *********               7 | 8 | 9                 ***************
      *********                                         ***************
      *********      When you have three matching       ***************
      *********              "XXX" or "OOO"             ***************
      *********                 You Win!                ***************
      *****************************************************************
      *****************************************************************
    HEREDOC
  end

  # Receive the names of players and assign their symbols to identify their play
  def player_prompt
    puts "\nPlayer 1, Please Enter your name: \n"
    @player1 = gets.chomp.capitalize
    if name_valid?(@player1)
      puts "#{@player1}, you use X as your symbol"
    else
      puts 'Enter a valid name. Name is String an 3-8 letters long'
      player_prompt
    end

    puts "\nPlayer 2, Please Enter your name: \n"
    @player2 = gets.chomp.capitalize
    if name_valid?(@player2)
      puts "#{@player2}, you use O as your symbol"
    else
      puts 'Enter a valid name. Name is String an 3-8 letters long'
      player_prompt
    end
  end

  # Ask for a move from the player
  def make_move_one
    puts "\n#{@player1}, make your move. [beween 1 and 9]"
    @move1 = gets.chomp.to_i
    return puts "you made your move #{@move1}. \nX will be place in position #{@move1}. " if move_valid?(@move1)

    puts display_warning
    make_move_one
  end

  def make_move_two
    puts "\n#{@player2}, make your move. [beween 1 and 9]"
    @move2 = gets.chomp.to_i
    return puts "you made your move #{@move2}. \nO will be place in position #{@move2}. " if move_valid?(@move2)

    puts display_warning
    make_move_two
  end

  # rubocop:disable Metrics/MethodLength
  def play
    instructions
    player_prompt
    puts show_board
    move = 1
    while move < 10
      if move.odd?
        make_move_one
        check_slots
        update_board(@move1, 'X')
        puts show_board
        @played.push(@move1)
        # move += 1
        # puts "move is: #{move}"
      else
        switch_player
        make_move_two
        check_slots
        update_board(@move2, 'O')
        puts show_board
        @played.push(@move2)
      end
      move += 1
      puts "move is: #{move}"
      win_or_draw
    end
  end
  # rubocop:enable Metrics/MethodLength

  def move_valid?(move)
    @slots[move - 1] == move and @played.none?(move)
  end

  def slots_full?
    @slots.all? { |cell| cell =~ /[^0-9]/ }
  end

  def switch_player
    if @curr_player == @player1
      @player2
    else
      @player1
    end
  end

  def check_slots
    !slots_full? and @played.none?
  end

  def win_or_draw
    if game_done?
      puts "#{@curr_player} wins"
    else
      puts "It's a tie"
    end
  end

  def display_warning
    "\e[31mSorry, invalid move! #{@played} are taken. Please, try again. \e[0m"
  end

  def name_valid?(name)
    if name.is_a?(String)
      true
    elsif name.match(/([a-zA-Z]+)/)
      true
    elsif name.strip.length.between?(3, 8)
      true
    else
      false
    end
  end
end

game1 = Game.new
game1.play
