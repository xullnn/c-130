# p "Many boys' fathers' age are over 50.".scan /\b[\w']+\b\'?/

class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words = @phrase.scan(/\b[\w\']+/)  # split words but keep all single quotation at the right side
                   .map { |word| word.sub(/([^s])\'\B/,'\1') } # if a word end with single quotation but the last letter is other than 's', delete that quotation
    count_words(words)
  end

  private

  def count_words(words)
    hash = Hash.new(0)
    words.each { |word| hash[word.downcase] += 1 }
    hash
  end
end

# "Many boys' fathers' age are 'over' 50.".gsub(/\B\W*\s\W*/, ' ')
# "Many boys' fathers' age are 'over' 50.".scan(/\b[\w\']+/)
# ["Many", "boys'", "fathers'", "age", "are", "over'", "50"].map do |word|
#   word.sub(/([^s])\'/,'\1')
# end
