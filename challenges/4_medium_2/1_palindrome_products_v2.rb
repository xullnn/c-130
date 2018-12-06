class Palindromes
  def initialize(min_max_factors)
    @max_factor = min_max_factors[:max_factor]
    @min_factor = min_max_factors[:min_factor] || 1
    @all_palindromes = find_all_palindromes
    @minmax_palindromes = {:largest => [], :smallest => []}
  end

  def generate
    min_value, max_value = @all_palindromes.minmax_by { |pair| pair.reduce(&:*) }
                                           .map { |pair| pair.reduce(&:*) }
    @minmax_palindromes[:largest] = @all_palindromes.select { |pair| pair.reduce(&:*) == max_value }
    @minmax_palindromes[:smallest] = @all_palindromes.select { |pair| pair.reduce(&:*) == min_value }
  end

  def largest
    @will_call = :largest
    self
  end

  def smallest
    @will_call = :smallest
    self
  end

  def value
    factors.last.reduce(&:*)
  end

  def factors
    @minmax_palindromes[@will_call]
  end

  private

  def find_all_palindromes
    all_combinations = (@min_factor..@max_factor).to_a.repeated_combination(2)
    all_combinations.select { |pair| is_palindrome?(pair.reduce(&:*)) }
  end

  def is_palindrome?(integer)
    integer.to_s == integer.to_s.reverse
  end
end
