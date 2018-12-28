# class name: RailFenceCipher
#
# input of encode:
#   - a string('' or 'hello world')
#   - a number => rows of rails
# output of encode:
#   - a encoded string ('ESXIEECSR')
#
# input of decode:
#   - encrypted string like 'ESXIEECSR', also the number of rails
# output of decode:
#   - ciphered string 'EXERCISES'
#
# Example:
# 1) string
#
#  "WE ARE DISCOVERED FLEE AT ONCE"
#
# 2) transponsed string(this step need not to actually implemented)
#   1       5       9       13      17      21      25  2n -2(interval)
#   W . . . E . . . C . . . R . . . L . . . T . . . E
    # 2   4   6   8  10   12  14  16  18  20  22  24    2
#   . E . R . D . S . O . E . E . F . E . A . O . C .
      # 3       7      11      15       19      23      2n - 2
#   . . A . . . I . . . V . . . D . . . E . . . N . .
#
# - empty spaces are ignored
#
# 3) encoded output string
#
# "WECRLTEERDSOEEFEAOCAIVDEN"
#
# Algorithm
#
# encode:
#   - remove all spaces
#   - count the chars' size
#     - get the single period (1..n).to_a + (n-1).downto(2).to_a and its size
#     - chars.size.to_f / period's size, then `ceil`
#       - the number of periods we need n_of_periods
#     - generate all periods numbers array * n
#     - generate a number_of_fences empty strings array as the encode container
#
#   - go through stripped string(need to encode)
#     - shift out a number from the periods array as the index
#     - push the char into the encoded strings array [index]
#   - join the n strings

# decode:
#   - through given encoded str => periods
    # - the only clues are the 1) size of the chars; 2) number of the fences
    # - find the pattern about the relationship between
    #   - single char
    #   - and its real order in decoded form
    #   - (see label above) I drew a 5 fence chart to verify the pattern
    # - intervals from up to down
    #   - (2..(2*n-2)).step(2).to_a.reverse << 2*n - 2
    # - first line and last line
    #   - max interval
    # - else(middle lines)
    #   - alternate: interval, (max_interval - interval), interval, (max_interval - interval),
    # - iterate through the encoded str
    #   hash.new
    #   hash[indicator.shift] = c
    #   sort hash


require 'pry'
class RailFenceCipher
  def self.encode(str, n)
    return str if n == 1 || n >= str.size
    new_str = str.delete(' ').upcase
    period_unit = (1..n).to_a + (n-1).downto(2).to_a
    periods_indicator =  period_unit * (new_str.size / period_unit.size.to_f).ceil
    encoded = n.times.with_object([]) { |_, arr| arr << String.new }
    new_str.chars.each do |c|
      index = periods_indicator.shift
      encoded[index-1] << c
    end
    encoded.join
  end

  def self.decode(str, n)
    return str if n == 1 || n >= str.size
    intervals = (2..(2*n-2)).step(2).to_a.reverse << 2*n - 2
    max_interval = intervals.max
    decode_indicator = intervals.map.with_index(1).with_object([]) do |(int, line), arr|
      arr << line
      if int == max_interval
        loop do
          arr << arr.last + int
          break if arr.last + int > str.size
        end
      else
        pair = [int, max_interval - int]
        loop do
          arr << arr.last + pair.first
          pair.reverse!
          break if arr.last + pair.first > str.size
        end
      end
    end
      p decode_indicator
    hash = str.chars.each_with_object({}) do |char, hash|
      hash[decode_indicator.shift] = char
    end.sort.map { |arr| arr[1] }.join
  end

end
