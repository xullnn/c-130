# PEDAC

# P
  # given a number range from 2 to n
  # find all primes in this range
    # by using Eratosthene's Algorithm

# E
  # test examples can tell
    # class Sieve
    # initialize method will take the ending point of the range
    # Sieve obj has a `prime` attribute to hold all the primes

# D
  # Array and Integer

# A
  # how to 'mark' a number as 'not a prime'
    # delete it ?
    # use hash like {2=>true, 3=>true, 4=>true} to keep track of if a integer is a prime?

# 1 use array
  # set an empty array to hold primes = []
  # loop do
    # iterate through numbers[1..-1] while numbers[1..-1]
      # delete element if current element % numbers.first == 0
      # shift out the first numbers to primes[]
  # loop end

class Sieve
  attr_reader :primes
  def initialize(n)
    @primes = generate_primes(n)
  end

  private

  def generate_primes(n)
    primes = []
    numbers = (2..n).to_a
    until numbers.empty?
      current_prime = numbers.shift
      numbers.delete_if { |number| number % current_prime == 0 }
      primes << current_prime
    end
    primes
  end
end
