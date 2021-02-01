#!/usr/bin/env ruby

require_relative '../lib/game_board'
require_relative '../lib/color'

class Game < GameBoard
  attr_reader :slot, :player1, :player2, :curr_player

  def initialize()
    super
    @played = []
    @player1_moves = []
    @player2_moves = []
    @curr_player = nil
    @move = []
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
  def player1_prompt
    puts "\nPlayer 1, Please Enter your name: \n"
    @player1 = gets.chomp
    if name_valid?(@player1)
      @player1 = @player1.capitalize.cyan
      puts "#{@player1}, you use X as your symbol"
    else
      puts 'Enter a valid name. Name is String an 3-8 letters long'
      player1_prompt
    end
  end

  def player2_prompt
    puts "\nPlayer 2, Please Enter your name: \n"
    @player2 = gets.chomp
    if name_valid?(@player2)
      @player2 = @player2.capitalize.brown
      puts "#{@player2}, you use O as your symbol"
    else
      puts 'Enter a valid name. Name is String an 3-8 letters long'
      player2_prompt
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
    player1_prompt
    sleep 1
    player2_prompt
    sleep 1
    puts show_board
    move = 1
    while move < 10
      if move.odd?
        @curr_player = @player1
        make_move_one
        update_board(@move1, 'X'.cyan)
        puts show_board
        @player1_moves.push(@move1 - 1)
        @played.push(@move1)
        @move = @player1_moves

      else
        @curr_player = @player2
        make_move_two
        update_board(@move2, 'O'.brown)
        puts show_board
        @player2_moves.push(@move2 - 1)
        @played.push(@move2)
        @move = @player2_moves
      end
      move += 1
      sleep 1
      if win?(@move)
        puts "\n#{@curr_player} WINS!"
        break
      elsif slots_full?
        puts "it's a draw"
      else
        sleep 1
        puts "\nGame On"
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def display_warning
    "\e[31mSorry, invalid move! #{@played} is/are taken. Please, try again. \e[0m"
  end

  def end
    puts "\nThank you for playing"
  end
end

game1 = Game.new
game1.play
game1.end
