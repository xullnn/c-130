# input
  # multiple lines of string
    # every line contains a encrypted name
# output
  # an array contains all the name in form of string

# build a dictionary to return the real letter

lowercase_rear = ('a'..'z').each_slice(13).to_a.reverse.flatten
uppercase_rear = lowercase_rear.map(&:upcase)

dictionary = {}
('a'..'z').each.with_index { |letter, idx| dictionary[letter] = lowercase_rear[idx] }
('A'..'Z').each.with_index { |letter, idx| dictionary[letter] = lowercase_rear[idx].upcase }

DICTIONARY = dictionary

secret_names = <<~NAME.split("\n")
  Nqn Ybirynpr
  Tenpr Ubccre
  Nqryr Tbyqfgvar
  Nyna Ghevat
  Puneyrf Onoontr
  Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
  Wbua Ngnanfbss
  Ybvf Unvog
  Pynhqr Funaaba
  Fgrir Wbof
  Ovyy Tngrf
  Gvz Orearef-Yrr
  Fgrir Jbmavnx
  Xbaenq Mhfr
  Fve Nagbal Ubner
  Zneiva Zvafxl
  Lhxvuveb Zngfhzbgb
  Unllvz Fybavzfxv
  Tregehqr Oynapu
NAME

def decode_secret_names(secret_names)
  secret_names.map do |secret_name|
    name = ''
    secret_name.each_char do |char|
      letter = DICTIONARY[char] || char
      name << letter
    end
    name
  end
end

puts decode_secret_names(secret_names)
