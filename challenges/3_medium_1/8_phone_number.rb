# class PhoneNumber
  # ::new takes a string of digits
  # #number
    # if valid input then printed out digits(may be trimmed)
    # if invalid input then return 10 zero
  # #area_code: get first 3 digits from the beginning of a valid number
  # to_s: format number with:
    # area_code in parentheses,
    # 1 empty space
    # next 3 digits
    # one hyphen
    # the rest

  # input and final output are all string

  # A
    # number
      #
      # delete all non digit and . - ()
      # return 10 zero if invalid
      # trim valid number

    # area_code
      # @area_code =

    # "(#{@area_code})  #{@number[3,3]}-#{@number[6,-1]}"

class PhoneNumber
  attr_reader :number

  def initialize(number)
    @number = trim_number(number)
  end

  def trim_number(number)
    return '0000000000' if number.match(/[^\d\.\-\(\)\s]/)
    number.delete!("^0-9")
    number[0] = '' if number.size == 11 && number.start_with?('1')
    number.size == 10 ? number : '0000000000'
  end

  def area_code
    @number[0,3]
  end

  def to_s
    "(#{area_code}) #{number[3,3]}-#{number[6..-1]}"
  end
end
