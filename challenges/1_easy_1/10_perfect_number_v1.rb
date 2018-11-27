class PerfectNumber
  def self.classify(number)
    raise if number < 0
    # sum_of_factors = (1..(number / 2)).select { |factor| number % factor == 0 }.sum
    sum_of_factors = (1..(number / 2)).reduce(0) { |sum, factor| number % factor == 0 ? sum + factor : sum }

      case sum_of_factors <=> number
      when 1 then 'abundant'
      when 0 then 'perfect'
      when -1 then 'deficient'
      end
  end
end
