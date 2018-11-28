# NUM_RULES = {
#   'M' => 1000,
#   'D' => 500,
#   'CD' => 400,
#   'C' => 100,
#   'L' => 50,
#   'XL' => 40,
#   'X' => 10,
#   'V' => 5,
#   'IV' => 4,
#   'I' => 1
# }

# initalize an empty str
# Iterate throught the NUM_RULES from top to down
  # let decimal number divided by value get the factor for current roman mark
    # then let key(string representation of the current mark) times the quotient from previous step
    # str << mark(could be empty str)
      # if current digit is 0 or less than current value
    # then update the decimal number to n % value
# return that str

# code logical into data structure

class Integer
  NUM_RULES = {
    'M' => 1000,
    'CM' => 900,
    'D' => 500,
    'CD' => 400,
    'C' => 100,
    'XC' => 90,
    'L' => 50,
    'XL' => 40,
    'X' => 10,
    'IX' => 9,
    'V' => 5,
    'IV' => 4,
    'I' => 1
  }

  def to_roman
    roman_number = ''
    decimal_number = self
    NUM_RULES.each do |roman_mark, decimal_value|
      n_of_roman, decimal_number = decimal_number.divmod(decimal_value)
      roman_number << roman_mark * n_of_roman
    end
    roman_number
  end
end
