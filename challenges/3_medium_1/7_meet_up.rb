require 'date'

# input:
#   1 initialize accepts (month, year) as integers
#   2 #day method accepts two symbols
#     # first is wday
#     # second is first second third fourth or last or teenth
# output:
#   a Date object that match the given conditions

#
  # what dates would end with teenth?
  #   13th...19th
  # so if the second arg of day is
  #   :teenth we should narrow down the search range in this scope
  #     pre_day = Date.new(y, month, 13)
  #     aft_day = Date.new(y, month, 19)
  #     pre_day.step(aft_day).select { |day| day.wday = n }
  #   :first to :last
  #     pre_day = Date.new(y, month)
  #     aft_day = Date.new(y, -1, -1)
  #     pre_day.step(aft_day).select { |day| day.wday = n }[th-1]

class Meetup
  WEEK_ORD = { :first => 0, :second => 1, :third => 2, :fourth => 3, :last => -1 }
  DAY_TO_NUM = {
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 0
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(wday, ord_num)
    if ord_num == :teenth
      teenth_days.select { |day| day.wday == DAY_TO_NUM[wday] }[0]
    else
      week_ord = WEEK_ORD[ord_num]
      days_in_a_month.select { |day| day.wday == DAY_TO_NUM[wday] }[week_ord]
    end
  end

  def teenth_days
    pre_day = Date.new(@year, @month, 13)
    aft_day = Date.new(@year, @month, 19)
    pre_day.step(aft_day)
  end

  def days_in_a_month
    pre_day = Date.new(@year, @month)
    aft_day = Date.new(@year, @month, -1)
    pre_day.step(aft_day)
  end
end
