class Octal
  def initialize(octal_str)
    @octal_str = octal_str
  end

  def to_decimal
    invalid = @octal_str =~ /[^0-7]/ || !@octal_str.is_a?(String)
    invalid ? 0 :calculate_decimal
  end

  private
  def calculate_decimal
    @octal_str.split('')
              .reverse
              .map(&:to_i)
              .each_with_index
              .reduce(0) do |result, (digit, index)|
                result + digit * (8 ** index)
              end
  end

end
