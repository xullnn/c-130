class PigLatin
  VOWEL_EXCEPTIONS = %w(honor r f h m s x)
  def self.translate(words)
    new(words).translate
  end

  def translate
    @words.split(' ').map { |word| transform(word) }.join(' ')
  end

  def initialize(words)
    @words = words
  end

  private

  def transform(word)
    if start_with_vowel?(word)
      word + 'ay'
    else
      consonant_transform(word)
    end
  end

  def start_with_vowel?(word)
    word.match(/\b[aoeiu]/) ||          # start with any vowels
    VOWEL_EXCEPTIONS.include?(word) ||  # exceptions containing consonant letters
    word.match(/\b[xy][^aoeiu]/)        # very special case start with x or y then follow other consonants
  end

  def consonant_transform(word)
    consonants = (word.match(/\bs?qu/) || word.match(/\b[^aoeiu]+/)).to_s
    word[0, consonants.size] = ''
    word << "#{consonants}ay"
  end
end
