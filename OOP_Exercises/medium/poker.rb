require 'pry'
require 'pry-byebug'
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_accessor :deck, :drawn

  def initialize
    @deck = new_deck
    @drawn = []
  end

  def draw
    if self.deck.empty?
      self.deck = new_deck
    end
    self.deck.pop
  end

  def new_deck
    deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
    deck.shuffle!
  end
end

class Card < Deck
  include Comparable

  attr_reader :rank, :suit
  RANKINGS = [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  SUIT_RANKS = ["Diamonds", "Clubs", "Hearts", "Spades"]

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    if rank == other.rank && suit != other.suit
      SUIT_RANKS.index(suit) <=> SUIT_RANKS.index(other.suit)
    else
      RANKINGS.index(rank) <=> RANKINGS.index(other.rank)
    end
  end
end

class PokerHand
  attr_accessor :hand, :deck

  def initialize(deck)
    @deck = deck
    @hand = []
    draw_hand
  end

  def draw_hand
    5.times { |_| hand << deck.draw }
    hand.sort!
  end

  def print
    hand.each { |card| puts "#{card}" }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def ranks
    ranks = hand.map {|card| card.rank }
  end

  def royal_flush?
    royals = Card::RANKINGS[-5..-1]
    straight_flush? && hand.all? { |card| royals.include?(card.rank) }
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind? # hand is pre sorted
    hand[0..3].all? { |card| card.rank == hand[0].rank } ||
      hand[1..4].all? { |card| card.rank == hand[1].rank }
  end

  def full_house?
    three_of_a_kind? && pair? && ranks.uniq.size == 2
  end

  def flush?
    suit = hand.first.suit
    hand.all? { |card| card.suit == suit }
  end

  def straight?
    9.times { |num| return true if Card::RANKINGS[num..num+4] == ranks }
    false
  end

  def three_of_a_kind?
    hand[0..2].all? { |card| card.rank == hand[0].rank } ||
    hand[1..3].all? { |card| card.rank == hand[1].rank } ||
    hand[2..4].all? { |card| card.rank == hand[2].rank }
  end

  def two_pair?
    count = 0
    4.times do |num|
      count += 1 if hand[num].rank == hand[num+1].rank
    end
    count == 2
  end

  def pair?
    4.times do |num|
      return true if hand[num].rank == hand[num+1].rank
    end
    false
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
