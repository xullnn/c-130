# Cipher:
#   - class methods
#     - initialize
#       - may or may not take a key as argument
#       - this key will be used to encode message
#       -  key is not composed of numbers or capital letters.
#         - or will raise exception
#         - key and encoded text are in an one-to-one relationship
#         - for example:
#           - plain: hello
#           - key:   abcab
#           - move:  01201
#           - encode:aceac
#       - if no key is given, generate a >= 100 chars key
#
#   - instance methods:
#     - encode
#     - decode
#     - key
#
# Algorithm:
#
# - build a table(hash) to index all lowercase letters
#   - { 'a' => 0, 'b' => 1, 'c' => 2 ... }
#
# - how to encypt
#   - iterate through plain chars with index
#     - retrieve same index char from key
#       - use key to retrieve moving steps
#         - call next n times on the plain char
    # - if plain is z(index:25) key is c(2) next won't work,
    #   - it should be 'b'(index intable is 1)
    #   - a.(1)times call next
    #   - a.(plain.index + key value) % 26
    #     - plain: z, key: f(5)
    #       - (25 + 5) % 26 = 4 => z,a,b,c,d
    #     - plain: a(0), key: a(0)
    #       - 0 % 26 = 0

# - how to decode
  # - if encoded: k(10), key: z(25), should be l(11) -15
  # - if encoded: x(23), key: f(5), should be s(18) -8
  # - if encoded: b(1), key: d(3), should be y(24) -2
  #     -


 # => {"a"=>0, "b"=>1, "c"=>2, "d"=>3, "e"=>4, "f"=>5, "g"=>6, "h"=>7, "i"=>8,
 #   "j"=>9, "k"=>10, "l"=>11, "m"=>12, "n"=>13, "o"=>14,
 #   "p"=>15, "q"=>16, "r"=>17, "s"=>18, "t"=>19, "u"=>20,
 #   "v"=>21, "w"=>22, "x"=>23, "y"=>24, "z"=>25}

class Cipher
  LETTERS = ('a'..'z').to_a
  IDX_TABLE = LETTERS.map.with_index { |l, i| [l, i] }.to_h
  attr_reader :key

  def generate_key
    100.times.with_object([]) { |_, arr| arr << LETTERS.sample }.join
  end

  def initialize(key = generate_key)
    raise ArgumentError if key.match(/[^a-z]/) || key.empty?
    @key = key
  end

  def encode(plain)
    plain.chars.map.with_index do |char, i|
      shift = (LETTERS.index(char) + IDX_TABLE[key[i]]) % 26
      LETTERS[shift]
    end.join
  end

  def decode(encoded)
    encoded.chars.map.with_index do |char, i|
      shift = LETTERS.index(char) - IDX_TABLE[key[i]]
      LETTERS[shift]
    end.join
  end
end
