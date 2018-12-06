# class House
#
#   ...
#
#   private
#
#   def pieces
#     [
#       ['the horse and the hound and the horn', 'that belonged to'],
#       ['the farmer sowing his corn', 'that kept'],
#       ['the rooster that crowed in the morn', 'that woke'],
#       ['the priest all shaven and shorn', 'that married'],
#       ['the man all tattered and torn', 'that kissed'],
#       ['the maiden all forlorn', 'that milked'],
#       ['the cow with the crumpled horn', 'that tossed'],
#       ['the dog', 'that worried'],
#       ['the cat', 'that killed'],
#       ['the rat', 'that ate'],
#       ['the malt', 'that lay in'],
#       ['the house that Jack built']
#     ]
#   end
# end

# what is the pattern
  #1 "This is " + current arr.first.captalize

  #2 "This is" + current arr.first \n
  #  current arr.last + previous arr.first

  #3 "This is" + current arr.first \n
  # current arr.last + previous arr.first \n
  #


# from top to down

# first index = 0
full_arr =     [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]

start_from_index = 0
full_rhyme = []
loop do
  break if start_from_index >= full_arr.size
  arr = full_arr[start_from_index .. -1]
  str = "This is #{arr.first.first}\n"
  first_index = 0
  loop do
    second_index = first_index + 1
    s1 = arr[first_index].to_a[1].to_s + ' ' + arr[second_index].to_a[0].to_s
    str << "#{s1}\n"
    first_index += 1
    break if first_index >= arr.size - 1
  end
  full_rhyme << str
  start_from_index += 1
end
puts full_rhyme.join("\n").strip
