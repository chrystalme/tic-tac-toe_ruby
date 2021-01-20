#!/usr/bin/env ruby

class Game
  attr_reader :player_1, :player_2, :curr_player

  def initialize
    @player_1 = player_1
    @player_2 = player_2
    @curr_player = nil
  end

  #Introduction to our game and how to play
  def instructions
    puts <<-HEREDOC
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

  #Receive the names of players and assign their symbols to identify their play
  def player_prompt
    puts "Player 1, Please Enter your name: \n"
    player_1 = gets.chomp.capitalize
    puts "#{player_1}, you use X as your symbol"
    
    puts "\nPlayer 2, Please Enter your name: \n"
    player_2 = gets.chomp.capitalize
    puts "#{player_2}, you use O as your symbol\n\n"
     
  end

  #Ask for a move from the player
  def make_move_1
   puts "\n#{player_1}, make your move. [beween 1 and 9]"
    move_1 = gets.chomp
    puts "you made your move #{move_1}"
    # puts "#{@player_1} has played on position #{move_1.to_s}"
  end
  def make_move_2
    puts "\n#{player_2}, make your move. [beween 1 and 9]"
    move_2 = gets.chomp
    puts "you made your move #{move_2}"
  end

  def play
    instructions
    player_prompt
    move = 0
    while move <= 8 do
      curr_player = player_1
      make_move_1
      move += 1
      switch_player
      make_move_2
      move += 1
    end
    puts "Game finished!"
  end

  # def change_turn
    
  # end

  def switch_player
    if curr_player == player_1
      player_2
    else
      player_1
    end
  end
  
end

game_1 = Game.new
game_1.play
