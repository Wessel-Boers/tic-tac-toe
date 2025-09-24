require 'colorize'

require_relative 'board'

class Match
  WINNING_COMBINATIONS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9], # Rows
    [1, 4, 7], [2, 5, 8], [3, 6, 9], # Columns
    [1, 5, 9], [3, 5, 7]             # Diagonals
  ]

  def initialize
    @board = Board.new
    @turn = 0
    @player
    @winner
    @finished = false
  end

  def start_match
    puts "\nStarting a Match...\n"
    @board.draw_board
    while @finished == false do
      @turn.even? ? @player = 1 : @player = 2
      take_turn 
    end
  end

  def take_turn
    print "Player #{@player}: Which square do you want? "
    chosen_square = take_user_input
    puts "Player #{@player} chose square '#{chosen_square}'"

    @player == 1 ? symbol = "♡" : symbol = "■"
    @board.replace_letter(chosen_square, symbol)
    @board.draw_board
    @board.update_squares(chosen_square, @player)

    if game_finished?
      puts "Congratulations to Player #{@player}! You are the winner.\n".colorize(:color => :light_white, :background => :magenta)
      @finished = true
      start_new_game
    end

    @turn += 1
  end

  def take_user_input
    while true
      square = gets.chomp
      if square.match?(/\A[1-9]\z/) && @board.not_chosen_before?(square)
        return square
        break
      else
        print "Please enter a single digit that has not been chosen yet (1-9). "
      end
    end
  end

  def game_finished?
    WINNING_COMBINATIONS.each do |combination|
      if @board.squares[combination[0]] == true && @board.squares[combination[1]] == true && @board.squares[combination[2]] == true
        @winner = 1
        return true
      end
      
      if @board.squares[combination[0]] == false && @board.squares[combination[1]] == false && @board.squares[combination[2]] == false
        @winner = 2
        return true
      end
    end
    
    if game_draw?
      puts "The game has ended in a draw."
      @finished = true
      start_new_game
    end
    return false
  end

  def game_draw?
    if @turn == 8
      return true
    end
    return false
  end

  def start_new_game
    print "Do you want to start a new game? (Y/N) "
    while true
      input = gets.chomp.downcase
      if input.match?(/\A[yn]\z/)
        input == "y" ? return Match.new.start_match : return print "Thanks for playing!"
        break
      else
        print "Please enter either Y for Yes or N for No."
      end
    end
  end
end