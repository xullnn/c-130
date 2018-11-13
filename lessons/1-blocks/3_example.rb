def echo_with_yield(str)
  yield if block_given?
  str
end

p echo_with_yield("hello")
puts "*" * 40
p echo_with_yield("hello!") { puts "world" }         # world
