class RailFenceCipher
  def self.encode(str, n)
    return str if n == 1 || n >= str.size
    periods_indicator = generate_periods_indicator(n, str)
    str.chars.values_at(*periods_indicator).join
  end

  def self.decode(str, n)
    return str if n == 1 || n >= str.size
    periods_indicator = generate_periods_indicator(n, str)
    periods_indicator.zip(str.chars).sort_by(&:first).map(&:last).join
  end

  def self.generate_periods_indicator(n, str)
    intervals = (2..(2 * n - 2)).step(2).to_a.reverse << 2 * n - 2
    ord_of_chars =
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
    ord_of_chars.map { |num| num - 1 }
  end
end

p RailFenceCipher.encode(('A'..'Y').to_a.join, 5)
