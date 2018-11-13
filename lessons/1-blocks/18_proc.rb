# def a_method(&block)
#   block.call
# end
#
# proc = Proc.new { puts "I am a proc." }
#
# a_method { puts "I am a proc." }
# a_method &proc
# p Proc.new { "I am a proc" }

proc = :madeup_method.to_proc

class Integer
  def madeup_method
    %w[one two three four][self - 1]
  end
end

class String
  def madeup_method
    self.upcase * 2
  end
end


p [1, 2, 3].map(&proc)
p ['a', 'b', 'c'].map(&proc)
