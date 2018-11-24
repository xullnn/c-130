# PEDAC
  # input: a otcal string
    # valid octal numbers are 0 -- 7
  # output: converted decimal number(integer)

# E
  # implied requirements:
    # invalid arguments will return 0, include:
      # numbers out of (0..7)
      # non-digits

# D
  # String
  # Integer

# A
  # validate the passed in argument
  # split the string into set of octal_digits
  # then reverse these octal_digits
  # set result = 0
  # octal.each_with_index |digit, index|
    #result += digit * (8 ** index)
  # result
  
class Octal
  def initialize(octal_str)
    @octal_str = octal_str
  end

  def to_decimal
    return 0 if invalid_octal_str?
    decimal = 0
    @octal_str.split('').reverse.map(&:to_i).each_with_index do |digit, index|
      decimal += digit * (8 ** index)
    end
    decimal
  end

  private

  def invalid_octal_str?
    @octal_str.match(/[89]|[^\d]/) || !@octal_str.is_a?(String)
  end
end
