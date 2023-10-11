=begin
    Write a textual description of the problem or exercise.
    Extract the major nouns and verbs from the description.
    Organize and associate the verbs with the nouns.
    The nouns are the classes and the verbs are the behaviors or methods.

Rock Paper Scissors is a game with two players, each player chooses between
3 options to play and each option has a counter part it either beats or loses to
(or ties with itself)

Rock beats Scissors
Scissors beats Paper
Paper beats Rock

Potential important nouns: Player, choice, rule

Potential important verbs: choose, compare

Player
  -choose
Move
Rule

=end
class Player
  attr_accessor :move, :name, :wins

  def initialize
    set_name
    @wins = 0
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  WINCON = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper','lizard'],
    'lizard' => ['paper', 'spock'],
    'spock' => ['rock', 'scissors']
  }

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value = 'lizard'
  end

  def >(other_move)
    WINCON[self.to_s].include?(other_move.to_s)
  end

  def <(other_move)
    !WINCON[self.to_s].include?(other_move.to_s)
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What is your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
      puts "Sorry you must enter a name"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Franky', 'T100'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer
  attr_reader :win_target, :move_history

  def initialize(win_target)
    @human = Human.new
    @computer = Computer.new
    @win_target = win_target
    @move_history = []
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "Lets play a match, first to #{win_target} wins is the chamption!"
  end

  def display_goodbye_message
    puts "Thanks for playing #{human.name}!"
  end

  def display_moves
    puts ""
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    @move_history << "#{human.name} chose #{human.move}"
    @move_history << "#{computer.name} chose #{computer.move}"
  end

  def display_wins
    puts ""
    puts "#{human.name} - #{human.wins} wins"
    puts "#{computer.name} - #{computer.wins} wins"
  end

  def display_game_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      @move_history << "#{human.name} won!"
      @move_history << ""
      human.wins += 1
    elsif human.move.to_s == computer.move.to_s
      puts "It's a tie!"
      @move_history << "It's a tie!"
      @move_history << ""
    else
      puts "#{computer.name} won!"
      @move_history << "#{computer.name} won!"
      @move_history << ""
      computer.wins += 1
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, please choose y or n."
    end
    answer == 'y'
  end

  def match_winner
    if human.wins == win_target
      puts "#{human.name} won the match!"
    else
      puts "#{computer.name} won the match!"
    end
  end

  def print_move_history
    puts "Would you like to see move history? Press y"
    choice = gets.chomp.downcase
    puts @move_history if choice == 'y'
  end

  def play
    display_welcome_message
    loop do
      loop do
        human.choose
        computer.choose
        display_moves
        display_game_winner
        display_wins #
        if human.wins == win_target || computer.wins == win_target
          match_winner
          break
        end
      end
      if !play_again?
        break
      else
        human.wins = 0
        computer.wins = 0
      end
    end
    print_move_history
    display_goodbye_message
  end
end

RPSGame.new(3).play

=begin
for the example with personalities you would need to have a behavior
attribute that you could set on initialization, or maybe an array of types
that would be randomly selected with the name.  Basically each instance
would need unique behavior information
=end






