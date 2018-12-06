# input string
# output integer

  # what is the pattern of input string
    # 'What is 53 plus 2?'
    # 'What is -1 plus -10?'
    # 'What is 2 multiplied by -2 multiplied by 3?'
    # 'What is -3 plus 7 multiplied by -2?'

  # 53 plus 2 => 53.send(:+, 2)
  # -3 plus 7 multiplied by -2?' => -3.send(:+, 7).send(:*, -2)

# A
  # split original string into 3 parts
      # "What is"
      # "n"
      # "the rest of the sentence"
  # store n as first receiver

  # parse the rest of the sentence
    # build a operation lookup hash
    # global subsititude all wordy operations like "multiplied by", "minus", "plus", "divided by" into math notation
    # try transform the string into nested array in the form of
    # # [['-', 2], ['*', -8], [], [], []]
    # iterate through the array, send every sub array to the first receiver
    #   first_receiver.send(*sub_arr)

class WordProblem
  WORD_TO_NOTIONS = {
    "plus" => '+',
    "minus" => '-',
    "multiplied by" => '*',
    "divided by" => '/'
  }

  def initialize(sentence)
    parts = sentence.partition(/[+-]?\d+/)
    @first_receiver = parts[1].to_i
    @notion_and_nums = parse_words(parts.last)
  end

  def parse_words(words)
    return nil if words.count('0-9').zero?
    clean_words = words.strip.delete('?')
    WORD_TO_NOTIONS.each { |literal, notion| clean_words.gsub!(literal, notion) }
    clean_words.split.each_slice(2).to_a
  end

  def answer
    raise ArgumentError unless @notion_and_nums
    @notion_and_nums.reduce(@first_receiver) do |receiver, (notion, num)|
      receiver.send(notion, num.to_i)
    end
  end
end
