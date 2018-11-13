def echo_with_yield(str)
  yield
  str
end

# echo_with_yield { puts "world" }
echo_with_yield("hello") { puts "world" }
# echo_with_yield("hello", "world") { puts "morning" }

echo_with_yield("hello!")
# no block given (yield) (LocalJumpError)
