# I, V, X,  L,  C,   D,   M
# 1, 5, 10, 50, 100, 500, 1000
#
# Placing I in front of the V - or placing any smaller number in front of
# any larger number - indicates subtraction. So IV means 4.
# After V comes a series of additions - VI means 6, VII means 7, VIII means 8.
#
# smaller number before - means subtraction
# smaller number after  - means addition
#
# 1900
#
# M + CM
#
# 194
#
# CLXXXXIV
#
# 196
#
# CLXXXXVI
#
# 2946
#
# MMCMXLVI

#
# divmod 2946
#
# for thousands: "M" * (number / 100)
#
# for hundreds:
#   if digit at hundreds is < than 3 use mulitple "C"s
#   if digit at hundreds is == 4 use subtraction "CD"
#   if digit at hundreds is == 5 use "D"
#   if digit at hundreds is > 5 but <= 8 use "D" + "C"s(<=3)
#   if digit at hundreds is == 9 use subtraction "CM"
#
# for tens:
#   if digit at tens is < than 3 use mulitple "X"s
#   if digit at tens is == 4 use subtraction "XL"
#   if digit at tens is == 5 use "L"
#   if digit at tens is > 5 but <= 8 use "L" + "X"s(<=3)
#   if digit at tens is == 9 use subtraction "XC"
# I, V, X,  L,  C,   D,   M
# 1, 5, 10, 50, 100, 500, 1000
#
# require 'pry'
# number = 1990 # XIX
# roman_marks = %w(I V X L C D M)
#
# digits = number.digits # 9 1
# length = digits.length # 2
# index = 0
# str = ''
# digits.each do |digit|
#       # binding.pry
#   marks = roman_marks[index,3]
#   case
#   when digit == 0
#   when digit <= 3 then str.prepend(marks.first * digit)
#   when digit == 4 then str.prepend(marks.first + marks[1])
#   when digit == 5 then str.prepend(marks[1])
#   when digit > 5 && digit <= 8 then str.prepend(marks[1] + marks.first * (digit - 5))
#   when digit == 9 then str.prepend(marks.first + marks.last)
#   end
#   index += 2
# end
# p str
class Integer
  ROMAN_MARKS = %w(I V X L C D M)
  
  def to_roman
    index = 0
    str = ''
    digits .each do |digit|
      marks = ROMAN_MARKS[index,3]
      case
      when digit == 0
      when digit <= 3 then str.prepend(marks.first * digit)
      when digit == 4 then str.prepend(marks.first + marks[1])
      when digit == 5 then str.prepend(marks[1])
      when digit > 5 && digit <= 8 then str.prepend(marks[1] + marks.first * (digit - 5))
      when digit == 9 then str.prepend(marks.first + marks.last)
      end
      index += 2
    end
    str
  end
end
