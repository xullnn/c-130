# reunderstand the problem
# input
  # string that might have some repeated information
  # 'AABBBCCCC' - repeated pattern
  #
  # 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB' - more complex form
  #
  # 'zzz ZZ  zZ' - with upcase lowercase and empty spaces
  #
  # '⏰⚽⚽⚽⭐⭐⏰' with special chars

# output
# represent repeated info by number + char
# unrepeated just leave it unchanged


module RunLengthEncoding
  def self.encode(string)
    count = 1
    str = ''
    string.chars.each.with_index do |char, index|
      if string[index + 1] == char
        count += 1
      else
        str << "#{counts_to_str(count)}#{char}"
        count = 1
      end
    end
    str
  end

  def self.decode(string)
    leading_chars = string.match(/(^\D+)/) ? "#{$1}" : ""
    rest = string.scan(/\d+\D+/).reduce(leading_chars) do |str, group|
      pieces_of_subset = group.partition(/\D{1}/)
      subset = pieces_of_subset[1] * pieces_of_subset[0].to_i + pieces_of_subset.last
      str + subset
    end
  end

  def self.counts_to_str(count)
    count == 1 ? '' : count.to_s
  end
end
