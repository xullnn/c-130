items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

# gather(items) do |*three, one|
#   puts three.join(', ')
#   puts one
# end

# gather(items) do |first, *seconds, third|
#   puts first
#   puts seconds.join(', ')
#   puts third
# end

# gather(items) do |first, *seconds|
#   puts first
#   puts seconds.join(', ')
# end

gather(items) do | first, second, third, fourth|
  puts "#{first}, #{second}, #{third} and #{fourth}"
end
