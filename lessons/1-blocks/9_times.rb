# returned_value = 5.times do |num|
#   puts num
# end
#
# p returned_value

def times(number)
  counter = 0
  while counter < number
    yield(counter)
    counter += 1
  end

  number
end


times(4) { |num| puts num  }
