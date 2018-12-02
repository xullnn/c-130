# Rule 1: If a word begins with a vowel sound, add an "ay" sound to the end of the word.
# Rule 2: If a word begins with a consonant sound, move it to the end of the word,
  # and then add an "ay" sound to the end of the word.


# input: a string contains one or more words separated by space
# ouput: also one string contains words processed

# only care about the beginning of the word
  # how to determine one or more letters in the beginning is vowel?
    # one 'aoeiu' at the beginning
    # in what situation consonant(s) at the beginning could be vowel?
      # ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      #  "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        # honor?
        # single 'r' 'f' 'h' 'm', 's' 'x'
        # y + another consonant

  # how to determine one or more letters in the beginning is consonant?
    # other than the situations about vowels

# E
  # class PigLatin
  # class method translate

# D
  # String
  # Array

# A

  # if start_with_vowel?
    # string[0].match /aoeiu/ or
    # VOWEL_EXCEPTIONS.include?(string) or
    # string.match /\b[xy][^aoeiu]/
  # + ay

  # else
    # move letters(s) from the beginning to the end then + ay
      # slice the consonant? match letters form the consonant
        # qu, squ

    # slice_consonant
       # consonants = string.match /\bs?[qu]/ || string.match /\b[^aoeiu]+/
       # string[0,consonants.size] = ''
       # string << "#{consonants}ay"

class PigLatin
  VOWEL_EXCEPTIONS = %w(honor r f h m s x)

  def self.translate(words)
    words.split(' ').map { |word| transform(word) }.join(' ')
  end

  def self.transform(word)
    if start_with_vowel?(word)
      word + 'ay'
    else
      consonant_transform(word)
    end
  end

  def self.start_with_vowel?(word)
    word.match(/\b[aoeiu]/) ||          # start with any vowels
    VOWEL_EXCEPTIONS.include?(word) ||  # exceptions containing consonant letters
    word.match(/\b[xy][^aoeiu]/)        # very special case start with x or y then follow other consonants
  end

  def self.consonant_transform(word)
    consonants = (word.match(/\b[^aoeiu]?qu/) || word.match(/\b[^aoeiu]+/)).to_s
    word[0, consonants.size] = ''
    word << "#{consonants}ay"
  end
end
