require 'pry'
require 'pry-byebug'

module Displayable
  private

  def display_score
    puts "#{human.name} #{human.wins} - #{computer.name} #{computer.wins}"
  end

  def clear
    system 'clear'
  end

  def joinor
    if board.unmarked_keys.size > 1
      "#{board.unmarked_keys[0..-2].join(', ')}, or #{board.unmarked_keys[-1]}"
    else
      board.unmarked_keys[-1].to_s
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe #{human.name}!"
    puts ""
    puts "#{win_target} victories wins the match!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe #{human.name}!  Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{human.name}'s piece is a #{human.marker}."
    puts "#{computer.name}'s piece is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def display_match_winner
    if human.wins == win_target
      puts "#{human.name} won the match!"
    else
      puts "#{computer.name} won the match!  Better luck next time!"
    end
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      display_human_win
    when computer.marker
      display_computer_win
    else
      display_tie
    end
  end

  def display_human_win
    puts "#{human.name} Won!"
    increment_wins(human)
  end

  def display_computer_win
    puts "#{computer.name} Won!"
    increment_wins(computer)
  end

  def display_tie
    puts "It's a tie!"
    @ties += 1
  end

  def display_play_again_message
    puts "Let's play again #{human.name}!"
    puts ''
  end
end

class TTTGame
  include Displayable

  attr_reader :board, :human, :computer
  attr_accessor :win_target, :ties

  def initialize(win_target)
    @board = Board.new
    @human = Human.new(board)
    @computer = Computer.new(board, human)
    @current_marker = first_move?
    @win_target = win_target
    @ties = 0
  end

  def play
    clear
    display_welcome_message
    match_play
    display_goodbye_message
  end

  private

  def match_play
    loop do
      main_game
      display_match_winner
      break unless play_match_again?
      reset
      display_play_again_message
    end
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      display_score
      break if human.wins == win_target || computer.wins == win_target
      ready_for_next_game?
    end
  end

  def first_move?
    answer = ''
    puts "Would you like to move first #{human.name}? (y/n)"
    loop do
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Invalid input please type y or n"
    end
    answer == 'y' ? human.marker : computer.marker
  end

  def current_player_moves
    if human_turn?
      human.move
      @current_marker = computer.marker
    else
      computer.move
      @current_marker = human.marker
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.full? || board.someone_won?
      clear_screen_and_display_board
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def ready_for_next_game?
    puts "Ready for round #{human.wins + computer.wins + ties + 1}?"
    puts "Press 'Enter' key to continue"
    gets.chomp
    clear
    @current_marker = first_move?
    clear
    board.reset
  end

  def increment_wins(player) # may need to make just wins += 1
    player.wins += 1
  end

  def play_match_again?
    answer = nil
    loop do
      puts "Would you like to play another match #{human.name}? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer
      puts "Sorry must be y or n"
    end
    answer == 'y'
  end

  def reset
    @ties = 0
    human.wins = 0
    computer.wins = 0 # these need to be reset before match
    board.reset
    @current_marker = first_move?
    clear
  end
end

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]
  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player < TTTGame
  @@marker_options = ("A".."Z").to_a
  attr_reader :name
  attr_accessor :marker, :wins, :board

  def initialize(board)
    @board = board
    @name = name_me
    @marker = choose_marker
    @wins = 0
  end
end

class Human < Player
  def move
    if board.unmarked_keys.size > 1
      board[choose_move] = marker
    else
      board[last_move] = marker
    end
  end

  private

  def name_me
    puts "Please enter your name:"
    @name = gets.chomp.capitalize
  end

  def choose_marker
    human_choice = ''
    puts "Please select any letter for your marker #{name}:"
    loop do
      human_choice = gets.chomp.upcase
      break if @@marker_options.include?(human_choice)
      puts "Please select a letter A-Z"
    end
    @@marker_options.delete(human_choice) # computers cant select the same
    human_choice
  end

  def choose_move
    puts "Choose square #{joinor}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry #{name}, not a valid choice"
    end
    square
  end

  def last_move
    square = nil
    puts "Last available choice is square: #{joinor}"
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry #{name}, you can only pick square #{joinor}."
    end
    square
  end
end

class Computer < Player
  NAMES = ['C3PO', 'Franky', 'Hal', 'Syl', 'Pattern']
  attr_reader :opponent

  def initialize(board, opponent)
    super(board)
    @opponent = opponent
  end

  def move
    if board.unmarked_keys.include?(5) # middle square takes priority
      board[5] = marker
    elsif available_win?(self) # computer wants to win
      winning_move
    elsif available_win?(opponent) # computer wants to not lose
      blocking_move
    else # choose an open square
      random_move
    end
  end

  private

  def name_me
    @name = NAMES.sample
  end

  def choose_marker
    @@marker_options.sample
  end

  def winning_move
    board[winning_square(winning_line(self))] = marker
  end

  def blocking_move
    board[winning_square(winning_line(opponent))] = marker
  end

  def random_move
    board[board.unmarked_keys.sample] = marker
  end

  def available_win?(player)
    Board::WINNING_LINES.each do |line|
      squares = board.squares.values_at(*line)
      if squares.count { |square| square.marker == player.marker } == 2 &&
         squares.count { |square| square.marker == Square::INITIAL_MARKER } == 1
        return true
      end
    end
    false
  end

  def winning_line(player) # broke into two methods, too complex for rubocop
    Board::WINNING_LINES.each do |line|
      squares = board.squares.values_at(*line)
      if squares.count { |square| square.marker == player.marker } == 2 &&
         squares.count { |square| square.marker == Square::INITIAL_MARKER } == 1
        return line
      end
    end
  end

  def winning_square(line) # pass in return of winning_line
    line.each do |el|
      return el if board.squares[el].marker == Square::INITIAL_MARKER
    end
  end
end

game = TTTGame.new(3)
game.play

# move methods to private / protected
