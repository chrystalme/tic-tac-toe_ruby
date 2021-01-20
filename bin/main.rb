#!/usr/bin/env ruby

class Game
  attr_reader :player1, :player2, :curr_player

  def initialize
    @player1 = player1
    @player2 = player2
    @curr_player = nil
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
          *****************************************************************#{'    '}
      #{'    '}
    HEREDOC
  end

  # Receive the names of players and assign their symbols to identify their play
  def player_prompt
    puts "Player 1, Please Enter your name: \n"
    player1 = gets.chomp.capitalize
    puts "#{player1}, you use X as your symbol"

    puts "\nPlayer 2, Please Enter your name: \n"
    player2 = gets.chomp.capitalize
    puts "#{player2}, you use O as your symbol\n\n"
  end

  # Ask for a move from the player
  def make_move_one
    puts "\n#{player1}, make your move. [beween 1 and 9]"
    move1 = gets.chomp
    puts "you made your move #{move1}"
    # puts "#{@player_1} has played on position #{move_1.to_s}"
  end

  def make_move_two
    puts "\n#{player2}, make your move. [beween 1 and 9]"
    move2 = gets.chomp
    puts "you made your move #{move2}"
    # puts "#{@player_1} has played on position #{move_1.to_s}"
  end

  def play
    instructions
    player_prompt
    move = 0
    while move <= 8
      make_move_one
      move += 1
      switch_player
      make_move_two
      move += 1
    end
    puts 'Game finished!'
  end

  # def change_turn

  # end

  def switch_player
    if curr_player == player1
      player2
    else
      player1
    end
  end
end

game1 = Game.new
game1.play
