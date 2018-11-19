# def divisors(number)
#   (1..number).find_all { |n| number % n == 0 }
# end
#
# p divisors(1) == [1]
# p divisors(7) == [1, 7]
# p divisors(12) == [1, 2, 3, 4, 6, 12]
# p divisors(98) == [1, 2, 7, 14, 49, 98]
# p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
#

# if number % 2 != 0
  # skip all even numbers

def divisors(number)
  half = number / 2
  chosen = [1,number]
  if number.odd?
    left = (3..half).find_all(&:odd?).find_all { |d| number % d == 0 }
    right = []
    left.reverse.each do |d|
      square = d**2
      right << square if square < number && square > half
    end
  else

  end
  (chosen + left + right).sort

end

p divisors(7)
p divisors(81)
p divisors(99400891)
# 6
# 1 2 3 6
#
# 81
# 1 3 9 27 81
#
# 15
# 1 3 5 15
#
# 28
# 1 2 4 7 14 28
