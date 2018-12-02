# new method takes integer
# addends method return luhn digits(array of integers)
# checksum method return the sum of luhn digits(Integer)
# valid? method check if checksum % 10 == 0
# Luhn::create method can add a (minimal?) digit to the passed in integer to make it a new valid one

# A
  # Luhn::new()
    # validate the input

  # addends
    # map throught the original digits with index
      # digit = digit * 2 if index.odd?
      # digit -= 9 if digit > 10
      # digit

  # checksum
    # addends.sum

  # valid?

  # Luhn::create
    # first caculate checksum for current number pre_checksum
    # then get the minimal differentiation for the last digit to reach 10 min_diff
    # add digit 0 to the given integer as a placeholder
      # 789 => 7890
      # [9, 8, 7] => [0, 9, 8, 7]
      # got a new checksum for this new number(added 0 or say times 10)
      # (10 - new checksum.first digit) % 10
        # the %10 is to handle the possible edge case that checksum.first digit == 0
      # since the appended new digit will always not to be doubled(cause it will be zero index in reversed order (from right to left))
       # we just need to append it


class Luhn
  def initialize(number)
    @original_num = number
  end

  def addends
    @original_num.digits.map.with_index do |digit, index|
      if index.odd?
        digit > 5 ? (digit * 2 - 9) : digit * 2
      else
        digit
      end
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(number)
    checksum_with_added_zero = new(number * 10).checksum
    diff = (10 - checksum_with_added_zero.digits.first) % 10
    number * 10 + diff
  end
end



def is_palindrome?(string)
  cleaned_str = erase_non_alphabetics(string)
  reverse_string(cleaned_str).downcase == cleaned_str.downcase
end

def reverse_string(string)
  string.chars.reduce('') { |new_str, char| new_str.prepend(char)}
end

def erase_non_alphabetics(string)
  string.chars.map { |char| (char.upcase == char && char.downcase == char) ? '' : char }.join
end

p is_palindrome? 'no, 809oN'

# def is_palindrome?(string)
#   cleaned_str = erase_non_alphabetics(string)
#   half_index = (cleaned_str.length / 2)
#   half_index.times do |index|
#     return false if cleaned_str[index] != cleaned_str[-index - 1]
#   end
#   true
# end
#
# def erase_non_alphabetics(string)
#   string.downcase.chars.map { |char| (char.upcase == char && char.downcase == char) ? '' : char }.join
# end
#
# p is_palindrome? 'no, 809oN'
