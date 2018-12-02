require 'date'
class Meetup
  DAY_START_FROM = {
    first: 1,
    second: 8,
    third: 15,
    fourth: 22,
    last: -7,
    teenth: 13
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(wday, ord_num)
    starting_day = Date.new(@year, @month, DAY_START_FROM[ord_num] )
    starting_day.step(starting_day + 6).find do |day|
      day.public_send("#{wday}?")
    end
  end

end
