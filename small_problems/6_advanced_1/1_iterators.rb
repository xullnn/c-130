# how to make(continuously return) infinite number of factorials
# say if we wanna do this from an empty array []

# 1 * 2
# 1 * 2 * 3
# 1 * 2 * 3 * 4


# factorials = [1]
# a = 1
# b = 2
#
# loop do
#   factorials << a * b
#   a = a * b
#   b += 1
#   break if b == 8
# end
# p factorials

# change it to Enumerator
  # the key is continuously pushing a new factorial into "yielder"

# factorial_factory = Enumerator.new do |y|
#   a = 1
#   b = 2
#   y << 1
#   loop do
#     y << a * b
#     a = a * b
#     b += 1
#   end
# end

# p factorial_factory.take(7)
#
# 7.times { p factorial_factory.next }
# p factorial_factory.next
#
# factorial_factory.rewind
# 7.times { p factorial_factory.next }

factorial_factory = Enumerator.new do |y|
  a = 1
  b = 2
  y << {"1" => 1}
  loop do
    y << {"#{b}" => (a * b)}
    a = a * b
    b += 1
  end
end
factorial_factory.each do |pair|
  k, v = pair.shift
  puts "#{k}: #{v}"
  break if k == "7"
end
