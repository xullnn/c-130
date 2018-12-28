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
  REPEATED_PATTERN = {
    [1, 1, 1, 2] => :one_pair,
    [1, 1, 3] => :three_of_a_kind,
    [1, 4] => :four_of_a_kind,
    [1, 2, 2] => :two_pair,
    [2, 3] => :full_house
  }


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
    if REPEATED_PATTERN[count_cards] then REPEATED_PATTERN[count_cards]
    elsif straight? && flush? then :straight_flush
    elsif straight_to_5? then :straight_to_5
    elsif straight? then :straight
    elsif flush? then :flush
    else :high_card
    end
  end
end
