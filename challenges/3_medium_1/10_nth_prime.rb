# assert_equal 104_743, Prime.nth(10_001)

# consider sieve
#   2
#   #2 3 #4 5 #6 7 #8 9 #...
#
# first set prime = 2, ord_of_prime = 1
# skipping_factors = [2]
# loop do
#   return prime if ord_of_prime == given nth
#   prime += 1
#   skip i skipping_factors.any? { |f| prime % f == 0  }
#   ord_of_prime += 1
# end
#

# class Prime
#   def self.nth(the_nth)
#     raise ArgumentError if the_nth < 1
#     prime = 2
#     ord_of_prime = 1
#     skipping_factors = [2]
#     loop do
#       return prime if ord_of_prime == the_nth
#       prime += 1
#       next if skipping_factors.any? { |f| prime % f == 0  }
#       ord_of_prime += 1
#       skipping_factors << prime
#     end
#   end
# end

class Prime
  def self.nth(the_nth)
    raise ArgumentError if the_nth < 1
    prime = 2
    ord_of_prime = 1
    @primes = [2]
    loop do
      return prime if ord_of_prime == the_nth
      prime += 1
      next unless is_prime?(prime)
      ord_of_prime += 1
      @primes << prime
    end
  end

  def self.is_prime?(number)
    @primes.each do |p|
      return false if number % p == 0
      return true if p**2 > number
    end
  end
end
