# def test(&block)
#   puts "What's the block: #{block}"
# end
#
# test { sleep(1) }

def test2(block)
  puts "hello"
  block.call
  puts "good-bye"
end

def test(&block)
  puts "1"
  test2(block)
  puts "2"
end

test { puts "xyz" }
