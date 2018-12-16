# class Factorials
#   include Enumerable
#
# end
#
# # n! = n(n-1)!
# # if n == 0 then n! == 1
# # def make_factorials(n)
# #   fs = [1]
# #   return fs if n == 0
# #   n.times do |x|
# #     fs << (x+1) * fs.last
# #   end
# #   fs
# # end
# p Factorials.new.take(7)

# factorials = [1]
# nth = 2
#
# loop do
#   factorials << nth * factorials.last
#   nth += 1
#   break if nth == 8
# end
#
# p factorials
#
#
# factorials = Enumerator.new do |y|
#   pre = 1
#   nth = 2
#   y << pre
#   loop do
#     y << (pre = nth * pre)
#     nth += 1
#   end
# end
#
# p factorials.take(7)

factorial_factory = Enumerator.new do |y|
  pre = 1
  nth = 2
  y << {"1" => 1} # what we pushed in
  loop do
    y << {"#{nth}" => (pre = nth * pre)} # what we pushed in
    nth += 1
  end
end

factorial_factory.each do |pair| # we take it out later on by using iteration methods
  k, v = pair.shift
  puts "#{k}: #{v}"
  break if k == "7"
end
