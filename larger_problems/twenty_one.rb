require 'pry'
require 'pry-byebug'

module Displayable
  def show_welcome_screen
    clear
    puts "Hi #{human.name} and welcome to TWENTY ONE!"
    puts ""
    puts ""
  end

  def show_rules
    puts "The game is simple, it's you VS The Dealer"
    puts "You will be given 2 cards that you can see"
    puts "The Dealer will be given 2 cards, but you can only see one!"
    puts "The goal is to get as close as you can to TWENTY ONE!"
    puts "You can Hit to draw a card, or Stay to keep your hand"
    puts "The Dealer MUST Hit until they have cards worth 17 or above"
    puts "If you go over TWENTY ONE! You BUST and The Dealer WINS!"
    puts "If The Dealer BUSTS, or you beat their score, you win!"
    puts ""
    puts ""
  end

  def show_values
    puts "Numbered cards are easy, they're worth their number"
    puts "Face cards (Jack, Queen, King) are worth 10"
    puts "Aces are tricky, they can be worth 11 OR 1"
    puts "If you would BUST, but have an ace, we change the value to 1 for you"
    puts "Everyone could use a second chance sometimes!"
    puts ""
    puts ""
  end

  def clear
    system 'clear'
  end

  def display_hit
    puts ""
    puts "#{name} hits and draws a #{hand[-1][0]} of #{hand[-1][1]}"
    puts "#{name}'s hand is worth #{hand_total}"
    puts ""
  end

  def display_turn_result
    display_busted if busted?
    puts "#{name} chose to stay with a hand worth #{hand_total}" unless busted?
    display_stay unless busted?
    puts ""
  end

  def display_stay
    total = hand_total
    if total == 21
      puts "Can't get any better than that!"
    elsif total < 21 && total >= 17
      puts "Now that's a great hand!"
    elsif total < 17 && total > 11
      puts "Hmmmm...that's a risky choice"
    else
      puts "I just...I don't even...please read the rules again, it might help?"
    end
  end

  def display_busted
    puts "OH NO!!!!! #{name.upcase} BUSTED AND LOST!"
    puts ""
  end

  def display_winner
    if computer_won?
      display_computer_won
    elsif human_won?
      display_human_won
    else
      puts "It's a tie!"
    end
  end

  def display_human_won
    puts "#{human.hand_total} beats #{computer.hand_total}"
    puts "#{human.name} is the winner!"
    human.wins += 1
  end

  def display_computer_won
    puts "#{computer.hand_total} beats #{human.hand_total}"
    puts "#{computer.name} is the winner!"
    computer.wins += 1
  end

  def show_wins
    puts "#{human.name} #{human.wins} - #{computer.name} #{computer.wins}"
    puts ""
  end

  def display_match_winner
    if human.wins > computer.wins
      puts "#{human.name} won the match!  Good Job :)"
    else
      puts "#{computer.name} won the match! Better luck next time #{human.name}"
    end
    puts ""
  end

  def show_goodbye
    puts "Thanks for playing #{human.name}!"
  end
end

class TOGame
  attr_reader :win_goal
  attr_accessor :human, :computer, :deck

  include Displayable

  POINTS = {
    "Ace" => [1, 11],
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "10" => 10,
    "Jack" => 10,
    "Queen" => 10,
    "King" => 10
  }
  def initialize(win_goal)
    clear
    @deck = Deck.new
    @human = Human.new(deck)
    @computer = Computer.new(deck)
    @win_goal = win_goal
  end

  def play
    clear
    show_welcome_screen
    show_rules
    show_values
    match_play
    show_goodbye
  end

  private

  def match_play
    loop do
      play_game if ready_to_play?
      display_match_winner
      reset_wins
      break unless play_again?
    end
  end

  def play_game
    loop do
      clear
      deal_hands
      take_turns
      display_winner
      show_wins
      ready_to_play? unless someone_won?
      reset
      break if someone_won?
    end
  end

  def take_turns
    human.take_turn
    computer.take_turn unless human.busted?
  end

  def ready_to_play?
    answer = nil
    loop do
      puts "Are you ready to play? (Press 'y')"
      answer = gets.chomp.downcase
      break if answer == 'y'
      puts "No worries, take your time!"
    end
    answer
  end

  def deal_hands
    deal_hand(human)
    deal_hand(computer)
    human.display_cards
    puts ""
    computer.display_cards
  end

  def deal_hand(player)
    player.hit
    player.hit
  end

  def someone_won?
    human.wins == win_goal || computer.wins == win_goal
  end

  def computer_won?
    human.busted? ||
      (human.hand_total < computer.hand_total && !computer.busted?)
  end

  def human_won?
    computer.busted? || human.hand_total > computer.hand_total
  end

  def play_again?
    puts "Would you like to play another match?"
    puts "Press 'y' to play, any other key to exit"
    choice = gets.chomp.downcase
    choice == "y"
  end

  def reset
    human.hand = []
    computer.hand = []
    self.deck = Deck.new
    human.deck = deck
    computer.deck = deck
  end

  def reset_wins
    human.wins = 0
    computer.wins = 0
  end
end

class Player
  include Displayable

  attr_reader :name
  attr_accessor :hand, :deck, :wins

  def initialize(deck)
    @name = name_me
    @wins = 0
    @hand = []
    @deck = deck
  end

  def hit_or_stay
    choice = ''
    loop do
      puts "Would you like to Hit (h) or Stay (s)"
      choice = gets.chomp.downcase
      break if choice == 'h' || choice == 's'
      puts "Please only enter 'h' or 's'"
    end
    choice
  end

  def hand_total
    total = 0
    hand.each do |card|
      total += if card[0] == "Ace"
                 TOGame::POINTS[card[0]][1] # adds 11
               else
                 TOGame::POINTS[card[0]]
               end
    end
    total - ace_correction(total)
  end

  def ace_included?
    hand.any? { |card| card[0] == "Ace" }
  end

  def ace_correction(total)
    current_total = total
    correction = 0
    hand.each do |card|
      if card[0] == "Ace" && current_total > 21
        correction += 10
        current_total -= 10
      end
    end
    correction
  end

  def hit
    card = deck.cards.sample
    hand << card
    deck.cards.delete(card)
  end

  def busted?
    hand_total > 21
  end
end

class Human < Player
  def name_me
    name = ""
    loop do
      puts "What is your name?"
      name = gets.chomp.capitalize
      break unless name.strip.empty?
    end
    name
  end

  def take_turn
    loop do
      break if busted? || hit_or_stay == 's'
      hit
      display_hit
    end
    clear
    display_turn_result
  end

  def display_cards
    name = self.name
    puts "#{name}'s hand has a"
    hand.each { |card| puts "#{card[0]} of #{card[1]}" }
    puts ""
    puts "#{name}'s' total is #{hand_total}"
  end
end

class Computer < Player
  NAMES = ["Pattern", "Skynet", "Hal", "Franky", "Optimus Prime", "Aizen"]

  def name_me
    NAMES.sample
  end

  def take_turn
    display_hidden_card
    puts "#{name}'s hand is worth #{hand_total}"
    puts ""
    until busted? || hand_total >= 17
      hit
      display_hit
    end
    display_turn_result
  end

  def display_cards
    puts "#{name} is showing a #{hand[1][0]} of #{hand[1][1]}"
    puts ""
  end

  def display_hidden_card
    puts "#{name}'s hidden card is a #{hand[0][0]} of #{hand[0][1]}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = new_deck
  end

  def shuffle
    cards.shuffle
  end

  def new_deck
    suits = ["Spades", "Diamonds", "Hearts", "Clubs"]
    numbers = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10"] +
              ["Jack", "Queen", "King"]
    deck = []
    suits.each do |suit|
      numbers.each { |number| deck << [number, suit] }
    end
    deck
  end
end

game = TOGame.new(3)
game.play
