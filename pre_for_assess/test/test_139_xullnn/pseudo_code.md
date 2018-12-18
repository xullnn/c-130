Understand the problem:

  class/module name: `Atbash`
  class method: `encode(plain)`

  implicit requirements:
    - after cyphered str should be lowercase
    - non-word chars would be ignored, including(space, punctuations and others)
    - cyphered string are split into 5 char chunk first, the last one might not be so

Data structure and Algorithm:

  - use hash to build a table
  - downcase str
  - global sub all non-word chars with `''`
    - `str.gsub(/\W/, '')`
  - go through str to sub every char
    - `str.chars.map { |c| hash[c] }.join`
    - edge case numbers(not in table)
  - split into 5 chars chunks(maybe `each_slice(5)`?)
