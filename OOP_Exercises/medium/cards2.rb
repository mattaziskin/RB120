=begin
The Deck class should provide a #draw method to deal one card. The Deck should
be shuffled when it is initialized and, if it runs out of cards, it should
reset itself by generating a new set of 52 shuffled cards.
=end
require 'pry'
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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.