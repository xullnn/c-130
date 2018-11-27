class SumOfMultiples
  def self.to(ending_num)
    self.new(3, 5).to(ending_num)
  end

  def initialize(*factors)
    @factors = invalid_or_no_factors?(factors) ? [3, 5] : factors
  end

  def to(ending_num)
    multiples = []
    @factors.each do |factor|
      num = 0
      while num < ending_num
        multiples << num unless multiples.include?(num)
        num += factor
      end
    end
    multiples.sum
  end

  private

  def invalid_or_no_factors?(factors)
    factors.empty? || factors.any? { |f| !f.is_a?(Integer) }
  end
end

p SumOfMultiples.new(5000).to(10000)
