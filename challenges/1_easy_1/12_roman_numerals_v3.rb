# THOUSANDS = %w(M MM MMM MMMM)
# HUNDREDS = %w(C CC CCC CD D DC DCC DCCC CM)
# TENS = %w(X XX XXX XL L LX LXX LXXX XC)
# ONES = %w(I II III IV V VI VII VIII IX)
# ROMAN_MRAKS = [ONES, TENS, HUNDREDS, THOUSANDS]

class Integer
  THOUSANDS = %w(M MM MMM MMMM)
  HUNDREDS = %w(C CC CCC CD D DC DCC DCCC CM)
  TENS = %w(X XX XXX XL L LX LXX LXXX XC)
  ONES = %w(I II III IV V VI VII VIII IX)
  ROMAN_MRAKS = [ONES, TENS, HUNDREDS, THOUSANDS]

  def to_roman
    roman_number = ''
    digits.each.with_index do |digit, index|
      next if digit == 0
      roman_number.prepend(ROMAN_MRAKS[index][digit - 1])
    end
    roman_number
  end
end
