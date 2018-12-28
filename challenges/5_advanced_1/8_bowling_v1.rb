# rearrange validation methods
#   - last_frame?
#   - frame_not_end?
#   ...
#
# reconsider the score rule of the last frame
#   - what if see the last frame as two frame? then keep the scoring rule consistent

# if 10th roll is 10 then get tow more throws
# if 10th roll is spare(sum == 10 size == 2), then get one more throw
# if 10th roll is open(size == 2 sum < 10) then no more

# Algorithm
#   - separate rules into two parts
#     - first 9 frames
#     - 10th to the last ball
#   - how to define first 9 frames(and the last frame(9th) is not end)?
#     - frame size <= 9 &&
#     - lastest frame pins.sum == [10] || (size == 2 && sum <= 10)
#   - how to define 10th to the rest?
#     - 'else' the first 9
#       - from 10th ...
#         - if frame not end?
#           - roll
#         - else
#           - if 10 th frame == [10] then 2 more balls
#           - if 10 th size == 2
#             - sum == 10 then 1 more ball
#             - sum < 10 then over
#
#     - how to track the progress of the game?
#       - not_over?
#         - balls_remained?
#         - first set balls to 20
#           - -=2 every frame end
#           - update at 10th(based on diff situations)

class Game
  def initialize
    @rolls = []
  end

  def latest_frame
    @rolls.last ? @rolls.last : []
  end

  def frame_finished?
    latest_frame == [10] || (latest_frame.size == 2 && latest_frame.sum <= 10)
  end

  def roll(pins)
    raise if game_completed?
    if    @rolls.size <= 9  then roll_in_first_9(pins)
    elsif @rolls.size == 10 then roll_at_10th(pins)
    end
  end

  def score
    raise if !game_completed?
    score = 0
    @rolls.each.with_index do |frame, nth|
      score +=
        if    frame == [10]   then @rolls[nth, 3].flatten.first(3).sum
        elsif frame.sum == 10 then @rolls[nth + 1].first + 10
        else  frame.sum
        end
    end
    score
  end

  private

  def roll_at_10th(pins)
    validate_last_roll(pins)
    latest_frame << pins
  end

  def roll_in_first_9(pins)
    validate_normal_roll(pins)
    frame_finished? || @rolls.empty? ? @rolls << [pins] : latest_frame << pins
  end

  def validate_normal_roll(pins)
    raise if !frame_finished? && (latest_frame.sum + pins > 10) || !(0..10).cover?(pins)
  end

  def validate_last_roll(pins)
    raise if latest_frame.sum < 20 && (latest_frame.sum + pins) > 20
  end

  def game_completed?
    return false if @rolls.size != 10
    latest_frame.size == 3 && (10..30).cover?(latest_frame.sum) ||
      latest_frame.size == 2 && latest_frame.sum < 10
  end
end
