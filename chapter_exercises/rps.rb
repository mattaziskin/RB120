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
  VALUES = ['rock', 'paper', 'scissors']

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

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
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
      puts "Please choose rock, paper, or scissors:"
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
  attr_reader :win_target

  def initialize(win_target)
    @human = Human.new
    @computer = Computer.new
    @win_target = win_target
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
    puts "Lets play a match, first to #{win_target} wins is the chamption!"
  end

  def display_goodbye_message
    puts "Thanks for playing #{human.name}!"
  end

  def display_moves
    puts ""
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_wins
    puts ""
    puts "#{human.name} - #{human.wins} wins"
    puts "#{computer.name} - #{computer.wins} wins"
  end

  def display_game_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.wins += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.wins += 1
    else
      puts "It's a tie!"
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
    if human.wins == 5
      puts "#{human.name} won the match!"
    else
      puts "#{computer.name} won the match!"
    end
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
        if human.wins == 5 || computer.wins == 5
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
    display_goodbye_message
  end
end

RPSGame.new(5).play


=begin
Things to track for keeping score
scoreboard must be created
win condition (< > methods) should increment wins
play loop needs a new break condition at x wins
initialize a game with x wins as the target
welcome message should say how many wins are needed (game state)
but player wins is player state?


=end