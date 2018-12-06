# input
  # max_factor: 99
  # min_factor: default to 1 if not given

  # #generate return an array of sub arrays
    # every sub array contain two factors that can produce a palindrome number
    # all sub array should be sorted to small to big(may be)

  # #smallest select palindromes sub arrays from low to high base on the product of elements inside every sub array
  # #largets do the opposite thing

  # #value take out the first sub array and calculate the product
  # #factors select out the first sub array and make a nested array


class Palindromes
  def initialize(min_max_factors)
    @max_factor = min_max_factors[:max_factor]
    @min_factor = min_max_factors[:min_factor] || 1
    @palindromes = []
  end

  def generate
    all_combinations = (@min_factor..@max_factor).to_a.repeated_combination(2)
    all_combinations.each do |pair|
      @palindromes << pair if is_palindrome?(pair.reduce(&:*))
    end
    @palindromes.sort_by! { |pair| pair.reduce(&:*) }
  end

  def select_factors(small_or_large)
    choice = small_or_large == :largest ? :last : :first
    @selected = @palindromes.select do |com|
      com.reduce(&:*) == @palindromes.send(choice).reduce(&:*)
    end
  end

  def largest
    @largests = select_factors(:largest)
    self
  end

  def smallest
    @largests = select_factors(:smallest)
    self
  end

  def value
    @selected.first.reduce(&:*)
  end

  def factors
    @selected
  end

  private

  def is_palindrome?(integer)
    integer.to_s == integer.to_s.reverse
  end
end
