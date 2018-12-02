 # Clock.at(9).to_s
 #

 # clock = Clock.at(10) + 3
 # assert_equal '10:03', clock.to_s
 # end

 # class Clock
 #  class method ::at takes one or two args
  # when one => only clock minutes default to 0
  # when two => specify both
 #  instance method: #to_s
 #  #+(minutes)
 #  #-(minutes)
 # ==(another)


# A
  # could use Ruby's Time from core but too many unnecessary data? like date info
  # implement a class only about hour and minute

  # # + minutes
  #   hour, minute = minutes.divmod(60)
  #   @hour += hour
  #   @minute += minute

  # only keep minutes info, until call to_s when convert to hour and minutes?
class Clock
  attr_reader :total_minutes

  def self.at(hour, minute = 0)
    new(hour, minute)
  end

  def initialize(hour, minute)
    @total_minutes = hour * 60 + minute
  end

  def +(minutes)
    @total_minutes = total_minutes + minutes
    self
  end

  def -(minutes)
    @total_minutes = total_minutes - minutes
    self
  end

  def ==(another)
    to_s == another.to_s
  end

  def to_s
    hour, minute = total_minutes.divmod(60)
    sprintf("%02d:%02d", hour, minute)
  end

  private

  def total_minutes
    @total_minutes % (24 * 60)
  end
end
