# "If man was meant to stay on the ground god would have given us roots"

# becomes

# ifmanwas
# meanttos
# tayonthe
# groundgo
# dwouldha
# vegivenu
# sroots

# then rotate strings to form new strings

# "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau"

# class Crypto
#   ::new takes the normal plain text
#
# object of Crypto
#   `normalize_plaintext` strip all non word chars then downcase them
#   `size` return how many lines the text will be splited
#   `plaintext_segments` return an array which contains splited, multiline plain text
#   `ciphertext` return encrypted strings without any space

# A
  # state1: plain
  # state2: striped & downcased
  # state3: splited plain
  # state4: transformed words

# how to rotate splited plain?
  # ifmanwas
  # meanttos
  # tayonthe
  # groundgo
  # dwouldha
  # vegivenu
  # sroots

# (0..@factor).map do |index|
#   # go through every sub string
#   # get char by index
#   splited_normal.map { |sub_str| sub_str[index] }.join
# end


class Crypto
  attr_reader :normalize_plaintext, :plaintext_segments, :size

  def initialize(text)
    @normalize_plaintext = text.gsub(/\W/, '').downcase
    @size = Math.sqrt(@normalize_plaintext.size).ceil
    @plaintext_segments = @normalize_plaintext.chars.each_slice(@size).map(&:join)
    @encrypted_words = encrypt_words
  end

  def normalize_ciphertext
    @encrypted_words.join(' ').strip
  end

  def ciphertext
    @encrypted_words.join
  end

  private

  def encrypt_words
    (0..@size).map do |index|
      @plaintext_segments.map { |sub_str| sub_str[index] }.join
    end
  end
end
