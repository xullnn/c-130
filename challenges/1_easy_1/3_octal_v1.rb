class Octal
  def initialize(octal_str)
    @octal_str = octal_str
  end

  def to_decimal
    return 0 if invalid_octal_str?
    @octal_str.split('')
              .reverse
              .map(&:to_i)
              .each_with_index
              .reduce(0) do |result, (digit, index)|
                result + digit * (8 ** index)
              end
  end

  private

  def invalid_octal_str?
    @octal_str.match(/[^0-7]/) || !@octal_str.is_a?(String)
  end
end
