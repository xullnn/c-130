class Series
  def initialize(string)
    valid_string = verify_string(string)
    @digits = valid_string.split('').map(&:to_i)
  end

  def slices(num)
    raise ArgumentError if num < 1 || num > @digits.size
    slices = []
    @digits.each_index do |index|
      break if index > @digits.size - num
      slices << @digits[index, num]
    end
    slices
  end

  private

  def verify_string(string)
    if !string.is_a?(String) || string.match(/[^\d]/)
      raise ArgumentError, 'Invalid input string.'
    else
      return string
    end
  end
end

# add !string.is_a?(String) to `verify_string`
# change slice process to manual way
