# PEDAC

# P
  # input: a string which contains serveral digits
    # need validation?
  # output: an array which contains all the subsequences of given digits sequence
    # subsequences have a fixed length -- the passed in argument of slices method
    # every subsequence should be wrapped into a sub array
    # subsequences are not in a form of consecutive string digits
      # they are independent integers

  # Series.new('01234')
    # it's a OOP not a procedural program

  # the argument of Series#slices() method should <= the passed in string
    # or it should raise ArgumentError

# E
  # besides all the given ones
  # what about we pass 0?
    # should return an empty array
  # what about we give non-integer argument to Series::new method?
    # should raise ArgumentError either

# D
  # string, array

# A
  # core processing steps
    # convert the string to array of digits
      # each_cons method


  # code structure
    # class Series
    # methods: Series::new, Series#slices
    # helper methods?


# C

class Series
  def initialize(string)
    valid_string = verify_string(string)
    @digits = string.split('').map(&:to_i)
  end

  def slices(num)
    raise ArgumentError if num < 1 || num > @digits.size
    @digits.each_cons(num).to_a
  end

  private

  def verify_string(string)
    if string.match(/[^\d]/)
      raise ArgumentError, 'Invalid input string.'
    else
      return string
    end
  end
end
