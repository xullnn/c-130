# PEDAC

# P
  # factors not include the number itself
  # the bigest factor will not greater than n/2
  # given number should be positive integers

  # input: integer
  # ouput: one of the number type => string

# E
  # assert_equal 'abundant', PerfectNumber.classify(12)
  # it has a PerfectNumber class
  # it has a classify class method which take an integer

  # edge case: negative number
    # assert_raises RuntimeError do
    #   PerfectNumber.classify(-1)
    # end

  # if the given number is negative? raise RuntimeError

# D
  # Integer
  # String


# A
  # raise error if negative
  # find out all factors
  # sum of factors
  # comparing sum with the number itself
  # return the type


class PerfectNumber
  def self.classify(number)
    @number = number
    raise if number < 0
    sum_of_factors = find_factors.sum
    return_type(sum_of_factors)
  end

  private

  def self.find_factors
    factors = []
    1.upto(@number / 2) { |factor| factors << factor if @number % factor == 0 }
    factors
  end

  def self.return_type(sum_of_factors)
    case sum_of_factors <=> @number
    when 1
      'abundant'
    when 0
      'perfect'
    when -1
      'deficient'
    end
  end
end
