#!/usr/bin/env ruby

class Game
  attr_reader :slot #:player1, :player2, :curr_player

  def initialize()
    @slots = [1, 2, 3, 4, 5, 6, 7, 8, 9]
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
    puts "#{@player1}, you use X as your symbol"

    puts "\nPlayer 2, Please Enter your name: \n"
    @player2 = gets.chomp.capitalize
    puts "#{@player2}, you use O as your symbol\n\n"
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
    return puts "you made your move #{@move2}. \nX will be place in position #{@move2}. " if move_valid?(@move2)

    puts display_warning
    make_move_two
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Lint/UselessAssignment
  def play
    instructions
    player_prompt
    move = 1
    num = 1
    while move < 10
      if move.odd?
        make_move_one
        check_slots
        show_board
        @played.push(@move1)
        move += 1
        puts "move is: #{move}"
        num = 2
      else
        switch_player
        make_move_two
        check_slots
        show_board
        @played.push(@move2)
        move += 1
        puts "move is: #{move}"
      end
    end
    puts "#{@player1} Won!"
  end

  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Lint/UselessAssignment
  def move_valid?(move)
    @slots[move - 1] == move and @played.none?(move)
    # if @slots.any?(move)
    #   true
    # else
    #   false
    # end
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

  def show_board
    puts <<~HEREDOC
       1 | 2 | 3
      --- --- ---
       4 | 5 | 6
      --- --- ---
       7 | 8 | 9
    HEREDOC
  end

  def display_warning
    "\e[31mSorry, invalid move! #{@played} are taken. Please, try again. \e[0m"
  end
end

game1 = Game.new
game1.play
