# 2 Ways
  # 1 build a dictionary
  # 2 utilize index of oreder characters
require 'pry'
class Hex
  def build_dictionary
    hash = {}
    ((0..9).to_a.map(&:to_s) + ('a'..'f').to_a).each.with_index do |char, value|
      hash[char] = value
    end
    hash
  end

  HEX_DIC = Hex.new.build_dictionary

  def initialize(hex_str)
    @hex_str = hex_str.downcase
  end

  def to_decimal
    @hex_str =~ /[^0-9a-fA-F]/ ? 0 : calculate_decimal
  end

  private

  def calculate_decimal
    @hex_str.split('').reverse.map.with_index do |hex_digit_char, index|
      HEX_DIC[hex_digit_char] * (16 ** index)
    end.sum
  end
end

p Hex.new('1').to_decimal == 1
p Hex.new('11').to_decimal == 17
p Hex.new('10').to_decimal == 16
p Hex.new('1F').to_decimal == 31
