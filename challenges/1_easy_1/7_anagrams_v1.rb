class Anagram
  def initialize(target_word)
    @target_word = target_word
    @num_of_chars = count_chars(@target_word) # number of chars for target_word is only counted one time
  end

  def match(words)
    words.select { |word| anagram?(word) }
  end

  private

  def anagram?(word)
    return false if @target_word.length != word.length || word.casecmp?(@target_word)
    @num_of_chars == count_chars(word)        # @num_of_chars let us don't have to process target_word every time of comparing
  end

  def count_chars(word)
    hash = Hash.new(0)
    word.each_char { |char| hash[char.downcase] += 1 }
    hash
  end
end

# case insensitive version of <=> `casecmp`returns 1 0 -1
# also has casecmp? returns boolean
