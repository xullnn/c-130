# input = 'AABBBCCCC'
# output = '2A3B4C'

# string

# class RunLengthEncoding

# class method: 'encode' takes the input string, returns the encoded string
# class method: 'decode' takes the input string, returns the decoded string

# boundary conditions
  # if the encoded string doesn't contain any numbers
  # return the string as it is?

  # if a piece of info is not single char is a graph icon?
  # recognize every piece by ord number not as char

# A
  # how to encode?
  # 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWW W B'
  # keep a counter to count how many times a char is repeated

module RunLengthEncoding
  def self.encode(string)
    count = 1
    str = ''
    string.chars.each_with_index do |char, index|
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
    rest = string.scan(/\d+\D+/).map do |group|
      num_and_char = group.partition(/\D{1}/)
      num_and_char[1] * num_and_char.first.to_i + num_and_char.last
    end.join
    leading_chars + rest
  end

  def self.counts_to_str(count)
    if count == 1
      ''
    else
      count.to_s
    end
  end

end
