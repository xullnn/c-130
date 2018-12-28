# terms
#   - A frame: 10 pins in a frame
#     - 2 chances to throw the ball
#
#   - open frame: after the second time throwing the ball in single frame
#     - there're also pins stand
#
#   - spare: just knock down all pins after second throw
#     - the combinations vary a lot: (1,9), (5,5)
#       - notice: (0, 10) is spare not a strike
#
#   - strike: knock down all the first time
#     - second time? don't have to throw
#
#
# score rules:
#
# - open: score = pins (no association with after @rolls)
# - spare: score = pins + number of pins of next throw
#                = 10 + next pins
# - strike: score = 10 + number of pins of next **two** throws
#                 = 10 + .next_pins + next.next_pins
#
# special case: 10th frame
#
# fill ball: Fill Ball: The bonus ball earned for getting a spare or two strikes
#            in the tenth frame. So named because it "fills" the last box on the
#            scoresheet for that game.
# - if 1st throw is strike
#   - get another 2 fill balls
#     - totally 3 throws
# - if 1st and 2nd is spare
#   - get another 1 ball
#     - totally 3 throws
# - if 1st and 2nd is open
#   - no more chance
#
# total score of the 10th is the total of pins, no additional rule
#
#
# How to keep track of the rolls
# - nested array?
#   - [[1,4], [2,3], [10], [0,10]....]
# - hash?
#   - { 1 => [1,4], 2 => [2,3], 3 => [10], 4 => [0,10]....10 => [???]]

# Algorithm
#
# use a hash to keep track of the score board
# - use a pointer frame_at to indicate the current frame
#   - frame_at should be updated after every `roll`
#     - if the roll is 10 frame_at += 1
#       - at the same time nth_ball reset to 1
#     - elsif the roll is second(nth_ball == 2) roll frame_at += 1
#       - at the same time nth_ball reset to 1
#     - else frame_at no change
#       - at the same time nth_ball update to 2
#
# calculate score
#   for first 9 frames { 1 => [1,4], 2 => [2,3], 3 => [10], 4 => [0,10]....9 => [???]]
#     - if [10] fetch_values from next tow kev/value pair
#       - flatten values get the first two then add to 10(strike)
#     - if [2,8] same but only fetch next 1 throw
#     - if [1,5] just sum
#   for last one just add all

class Game
  def initialize
    @rolls = []
  end

  def roll(pins)
    raise if game_complete?
    validate_normal_roll(pins)
    if @rolls.empty? then @rolls << [pins]
    elsif @rolls.size <= 9 && (@rolls.last.size == 2 || @rolls.last.sum == 10)
      @rolls << [pins]
    else
      validate_last_roll(pins)
      @rolls.last << pins
    end
  end

  def score
    raise if !game_complete?
    score = 0
    @rolls.each.with_index do |frame, nth|
      if frame == [10]
        score += @rolls[nth, 3].flatten.first(3).sum
      elsif frame.size == 2 && frame.sum == 10
        score += @rolls[nth + 1].first.to_i + 10
      else
        score += frame.sum
      end
    end
    score
  end

  private

  def validate_normal_roll(pins)
    raise if !(0..10).cover?(pins)
    raise if @rolls.last && @rolls.last != [10] && @rolls.last.size == 1 && (pins + @rolls.last[0]) > 10
  end

  def validate_last_roll(pins)
    last_frame = @rolls.last
    raise if last_frame.sum < 20 && (last_frame.sum + pins) > 20
  end

  def game_complete?
    return false if @rolls.size != 10
    @rolls.last.size == 3 && (10..30).include?(@rolls.last.sum) ||
    @rolls.last.size == 2 && @rolls.last.sum < 10
  end
end
