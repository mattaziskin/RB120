=begin
Create an object-oriented number guessing class for numbers in the range 1 to
100, with a limit of 7 guesses per game. The game should play like this:

game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guess remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!
=end
require 'pry'
module Displayable

  private

  def display_welcome_screen
    puts "Welcome to the Guessing Game"
    puts "I picked a number between 1 and 100"
    puts "It's up to you to read my thoughts!"
    puts "You've got 7 tries, think luck is on your side?"
    puts ""
  end

  def display_ready?
    choice = ''
    loop do
      puts "Are you ready to play? (Press 'y')"
      choice = gets.chomp.downcase
      break if choice == 'y'
      puts "That's okay, take your time!"
    end
    clear
  end

  def clear
    system 'clear'
  end

  def display_guess_request
    if guesses < (limit - 1)
      puts "You have #{limit - guesses} guesses remaining"
    else
      puts "You have #{limit - guesses} guess remaining"
    end
    puts "Please enter a number between 1 and 100"
    puts ""
  end

  def display_invalid_guess
    puts "Invalid entry, please enter a whole number between 1 and 100"
  end

  def display_guess_output(guess)
    if invalid_entry?(guess)
        display_invalid_guess
        return
    end
      puts "Too Low!" if guess < number
      puts "Too High!" if guess > number
  end

  def display_outcome(guess)
    if guess == number
      puts "You got the number!"
    else
      puts ""
      puts "No more guesses!"
      puts "Drat! Better luck next time!"
    end
  end
end

class GuessingGame
  include Displayable

  attr_accessor :guesses
  attr_reader :number, :limit
  def initialize
    @limit = 7
    @number = (1..100).to_a.sample
    @guesses = 0
  end

  def play
    clear
    display_welcome_screen
    display_ready?
    guess_loop
  end

  private

  def guess_loop
    guess = ''
    until guess == number || guesses == limit
      guess_request
      guess = gets.chomp.to_i
      display_guess_output(guess)
      self.guesses += 1
    end
    display_outcome(guess)
  end

  def guess_request
    display_guess_request
  end

  def invalid_entry?(guess)
    !(1..100).include?(guess)
  end
end



game = GuessingGame.new
game.play

=begin
LS method

class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

=end
