# PEDAC

# P

  # input ? trinary string
    # what is valid trinary string: can only contain 0, 1 or 2

  # output ? decimal integer
    # what if the input trinary string is illegal？ => 0

# E

  # what we can get from the test
    # it has a class Trinary which has:
      # initialize method take a trinary string
      # instance mtehod `to_decimal`

# D

  # String
  # Integer
  # Array

# A

# split then reverse the trinary string
# transform all chars to integer
# apply conversion rule on every char, then sum them up
  # for every single char
    # 1s, 3s, 9s, 27s .... (3's power of index) multiply by currently iterating integer

# validation step
  # valid trinary string is /[^0-2]/
  # invalid_trinary_str?

# takes the string
# validate string
# calculate_decimal

# C
class Trinary
  def initialize(string)
    @trinary_str = string
  end

  def to_decimal
    invalid? ? 0 : calculate_decimal
  end

  private

  def invalid?
    @trinary_str =~ /[^0-2]/ || !@trinary_str.is_a?(String)
  end

  def calculate_decimal
    @trinary_str.split('')
                .reverse
                .map(&:to_i)
                .each_with_index
                .reduce(0) do |result, (digit, index)|
                  result + (3 ** index) * digit
                end
  end
end
