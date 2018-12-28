class RailFenceCipher
  def self.encode(str, n)
    return str if n == 1 || n >= str.size
    encode_indicator = ((1..n).to_a + (n - 1).downto(2).to_a).cycle
    encoded_strs = n.times.with_object([]) { |_, arr| arr << String.new }
    str.chars.each { |c| encoded_strs[encode_indicator.next - 1] << c }
    encoded_strs.join
  end

  def self.decode(str, n)
    return str if n == 1 || n >= str.size
    intervals = (2..(2 * n - 2)).step(2).to_a.reverse << 2 * n - 2
    decode_indicator = generate_decode_indicator(intervals, str)
    assemble_str(str, decode_indicator)
  end

  def self.assemble_str(str, decode_indicator)
    chars_with_ord = str.chars.each_with_object({}) do |char, hash|
      hash[decode_indicator.shift] = char
    end
    chars_with_ord.sort.map { |arr| arr[1] }.join
  end

  def self.generate_decode_indicator(intervals, str)
    intervals.map.with_index(1).with_object([]) do |(int, line_ord), arr|
      arr << line_ord
      if int == intervals.max
        arr << arr.last + int until arr.last + int > str.size
      else
        period = [int, intervals.max - int].cycle
        loop do
          next_point = arr.last + period.next
          break if next_point > str.size
          arr << next_point
        end
      end
    end
  end
end


p RailFenceCipher.encode(('A'..'Y').to_a.join, 5)
