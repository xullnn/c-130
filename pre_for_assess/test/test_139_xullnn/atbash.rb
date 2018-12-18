class Atbash
  def self.make_decipher_table
    hash = {}
    chars = ('a'..'z').to_a
    chars.each.with_index(1) { |c, i| hash[c] = chars[-i] }
    hash
  end

  DECIPHER_TABLE = make_decipher_table

  def self.encode(plain)
    dried_str = plain.downcase.gsub(/\W/, '')
    ciphered_str = dried_str.chars.map do |c|
      DECIPHER_TABLE[c] ? DECIPHER_TABLE[c] : c
    end.join
    ciphered_str.chars.each_slice(5).map(&:join).join(' ')
  end
end
