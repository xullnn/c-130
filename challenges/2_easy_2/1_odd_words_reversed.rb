# input
  # many words separated by one or more spaces
  # terminate by a single period

# output
  # new string which with words at odd indexes reversed
  # words at even indexes should not be changed
  # if the last word's index is odd, the period should be at the right position

# test cases
  # 'I am a monkey.' => 'I ma a yeknom.'
  # 'He is a   chimp.' => 'He si a pmihc.'

# D
  # String
  # Array

# A
  # make a copy of the sentence, delete the last period
  # split the sentence by one or more spaces
    # map throught the words with index
    # do the reverse work
    # join back by on space
  # add the period to the end

  # scan through the sentence by /\b\w+\b/
  # reverse
  # add period

def reverse_odds(sentence)
  return '' if sentence.empty?
  words = sentence.scan(/\b\w+\b/)
  new_words = words.map.with_index do |word, index|
    index.odd? ? word.reverse : word
  end
  new_words.join(' ') << '.'
end

p reverse_odds('') == ''
p reverse_odds(' .') == '.'
p reverse_odds('Ha .') == 'Ha.'
p reverse_odds('I am a monkey    .') == 'I ma a yeknom.'
p reverse_odds('He is a   chimp  .') == 'He si a pmihc.'

# use manual index + loop
