# https://en.wikipedia.org/wiki/List_of_poker_hands#Straight_flush

# logical checking order
  # full house?
  # two pair
  # four of a kind, three of a kind, one pair

  # straight && flush
  # straight or flush

  # high card
    # determined by the max value
# input
#   - multiple array of strs
#     - ['rank/suit','rank/suit'...]
#     - rank(value): 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A
#     - suit: S, H, C and D (Spades, Hearts, Clubs and Diamonds).
#
# output
#   - the best hand among the given ones, encapsulated by an array
#
# Algorithm
#
# assign different values to different categorie
#   - hash table { straight:1, flush:2 ... }
# evaluate the hands passed in, choose highest one

# logical checking order
  # full house?
  # two pair
  # four of a kind, three of a kind, one pair

  # straight && flush
  # straight or flush

  # high card

# consider if two hands are in the same type
# for example
  # two pair vs two pair
  # flush vs flush
  # 3 of a kind vs 3 of a kind
# If two or more players have two pair, then the highest pair determines the winner.

# %w(4S 5S 7H 8D JC)
#
# [[4, 'S'], [5, 'S'], [7, 'H'], [8, 'D'], [11, 'C']]

class Poker
  RANKING_TABLE = { straight_flush: 10,
                    four_of_a_kind: 9,
                    full_house: 8,
                    flush: 7,
                    straight: 6,
                    straight_to_5: 5,
                    three_of_a_kind: 4,
                    two_pair: 3,
                    one_pair: 2,
                    high_card: 1 }

  def initialize(cards)
    @cards = cards
  end

  def best_hand
    hands = @cards.map { |hand| Hand.new(hand) }
    @cards.select { |hand| Hand.new(hand) == hands.max }
  end
end

class Hand
  include Comparable
  attr_reader :score, :type, :values

  RANKS = %w[2 3 4 5 6 7 8 9 T J Q K A]
  RANK_VALUES =
    RANKS.each.with_index(2).with_object({}) do |(rank, value), h|
      h[rank] = value
    end

  def initialize(hand)
    @hand = hand.map { |pair| [RANK_VALUES[pair[0]], pair[1]] }
    @values = @hand.each_with_object(Hash.new(0)) { |pair, h| h[pair[0]] += 1 }
    @type = find_out_type
  end

  def determinative_factor
    if [:straight_flush, :flush, :straight, :high_card].include?(type)
      values.keys.max
    elsif [:one_pair, :two_pair].include?(type)
      values.select { |_, amount| amount == 2 }.keys.max
    else
      values.select { |_, amount| amount > 2 }.keys.max
    end
  end

  def score_on_type
    Poker::RANKING_TABLE[type]
  end

  def <=>(another)
    if values.keys == another.values.keys then 0
    elsif type != another.type
      score_on_type > another.score_on_type ? 1 : -1
    elsif determinative_factor > another.determinative_factor then 1
    elsif determinative_factor == another.determinative_factor then 0
    else -1
    end
  end

  def count_cards
    values.values.sort
  end

  def full_house?
    count_cards == [2, 3]
  end

  def two_pair?
    count_cards == [1, 2, 2]
  end

  def n_of_a_kind?(n)
    count_cards == [1] * (5 - n) << n
  end

  def one_pair?
    n_of_a_kind?(2)
  end

  def straight?
    return false if @values.keys.size != 5
    @values.keys.sort.reduce do |c1, c2|
      c1 - c2 == -1 ? c2 : (return false)
    end
  end

  def straight_to_5?
    @values.keys.sort == [2, 3, 4, 5, 14]
  end

  def flush?
    @hand.map { |pair| pair[1] }.flatten.uniq.size == 1
  end

  def find_out_type
    if full_house? then :full_house
    elsif two_pair? then :two_pair
    elsif n_of_a_kind?(4) then :four_of_a_kind
    elsif n_of_a_kind?(3) then :three_of_a_kind
    elsif one_pair? then :one_pair
    elsif straight? && flush? then :straight_flush
    elsif straight_to_5? then :straight_to_5
    elsif straight? then :straight
    elsif flush? then :flush
    else :high_card
    end
  end
end
