# PEDAC

# P
  # input: a string/word
  # output: array which contains zero or more anagrams(string)

  # anagram? must meet:
    # the length of both words should be the same
    # number of very letters is same
    # case insensitive
    # same word cannot be counted

# E
  # it has class Anagram
  # it has initialize method which takes a string(target word)
  # it has a match() method which takes in all the words(an array of strings) that we need to search

# D
  # string
  # array
  # integer
  # hash

# A
  # find out the length of the target word
  # find out the number of every letter of target word
  # store them into separate instance variables

  # iterate through the given list
    # if current word's length is not equal to the target one, it can be omitted
    # check if the number of each chars for the current word is the same as the target one's
      # if true, keep it
      # if false, skip
  # return that list


class Anagram
  def initialize(target_word)
    @target_word = target_word
    @length = target_word.length
    @num_of_chars = count_chars(@target_word)
  end

  def match(words)
    words.select do |word|
      next if @length != word.length || word.downcase == @target_word.downcase
      count_chars(@target_word) == count_chars(word)
    end
  end

  private

  def count_chars(word)
    hash = Hash.new(0)
    word.each_char { |char| hash[char.downcase] += 1 }
    hash
  end
end
