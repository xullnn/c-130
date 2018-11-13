# def call_me(some_code)
#   some_code.call
# end
#
# name = nil
# p chunk_of_code = Proc.new { puts "Hi, #{name}." }
# name = "Xullnn"
# chunk_of_code.call
#
# # call_me(chunk_of_code)

# def a_method(&block)
#   p block.class
# end

a_proc = Proc.new { |item| item * 2 }

class Object
  def a_method
    self % 2
  end
end

p [1, 2, 3].map(&a_proc)

p [1, 2, 3].map(&:a_method)

p ['A', 'B', 'C'].map(&:a_method)

p [1, 2, 3].map(&(:a_method.to_proc))
