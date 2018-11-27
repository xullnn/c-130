# PEDAC

# P
  # count the number of occurrences for each word in a string
  # input: string
  # output hash

  # non-alphabetic chars should not be counted (except for things like `don't`, what's)
  # new line character not count
  # decimal dights count
  # word counting shoule be case insensitive
    # means "go Go gO" shoule be {go => 3} an the key is lowercase
  # nested quotations should not be included in the count keys

# E
  # it has a Phrase class
  # it has a initialize method which takes a string
  # it has a word_count method counts the result
  #

# D
  # String
  # Hash
  # Array

# A
  # preprocess for the passed in string?
  # global substitude /[^\w^\']/ with empty space
  # global substitude \' at word boundaries with empty space

    # w = "Joe can't tell between 'large' and large.".gsub(/[\s\'][\'\s]/, ' ')
    # p w.gsub(/[^\w\']/, ' ').split(/\s+/)
    #
    # w = 'car : carpet as java : javascript!!&@$%^&'.gsub(/[\s\'][\'\s]/, ' ')
    # p w.gsub(/[^\w\']/, ' ').split(/\s+/)
    #
    #
    # w = "one,\ntwo,\nthree".gsub(/[\s\'][\'\s]/, ' ')
    # p w.gsub(/[^\w\']/, ' ').split(/\s+/)

  # build a hash with defaut value 0 to count the numbers
  # case insensitive:
    # downcase while adding new keys or increment existing keys

class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words = @phrase.gsub(/[\s(\'|\")][(\'|\")\s]/, ' ') # eliminate single quotation mark at word boundaries
                   .gsub(/[^\w\']/, ' ')      # eliminate all punctuations except for single qutations
                   .split(/\s+/)              # split string by 1 or more spaces
  count_words(words)
  end

  private

  def count_words(words)
    hash = Hash.new(0)
    words.each { |word| hash[word.downcase] += 1 }
    hash
  end
end
