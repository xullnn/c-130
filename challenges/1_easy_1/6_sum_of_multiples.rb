# PEDAC

# P
  # input: an ending number; zero or more factor numbers
  # output: an integer

  # default factors is 3 and 5 (means if we don't give any)
  # the ending number will not be included

# E
  # it has a class SumOfMultiples
  # it has an initialize method which may or may not take ending numbers
  # it has a to() method which takes the ending number

# D
  # Integer
  # Array

# Algorithm
  # if no given factors => set two default ones: 3 and 5
  # otherwise, set them to the given one(s)

  # iterate throught every factors |factor|
    # num = 0
    # loop do
    #   num += factor
    #   break if num >= ending point
    #   multiples << num
    # end
  # end iteration
  # sum multiples

class SumOfMultiples
  def self.to(ending_num)
    SumOfMultiples.new.to(ending_num)
  end

  def initialize(*factors)
    if invalid_or_no_factors?(factors)
      @factors = [3, 5]
    else
      @factors = factors
    end
  end

  def to(ending_num)
    multiples = []
    @factors.each do |factor|
      num = 0
      loop do
        num += factor
        break if num >= ending_num
        multiples << num unless multiples.include?(num)
      end
    end
    multiples.sum
  end

  private

  def invalid_or_no_factors?(factors)
    factors.any? { |factor| !factor.is_a?(Integer) } ||
    factors.empty?
  end
end
