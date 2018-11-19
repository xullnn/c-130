def convert_to_base_8(n)
  n.to_s(8).to_i # replace these two method calls
end

# The correct type of argument must be used below
# base8_proc = proc { |num| convert_to_base_8(num) }
base8_proc = method(:convert_to_base_8).to_proc

# We'll need a Proc object to make this code work. Replace `a_proc`
# with the correct object
p [8, 10, 12, 14, 16, 33].map(&base8_proc)

# [10, 12, 14, 16, 20, 41]

# def a_method(one, two)
#   puts "one is #{one}"
#   puts "two is #{two}"
# end
#
# method_obj = method(:a_method)
# method_proc = method_obj.to_proc
#
# [[1,2,3], [4,5,6]].each_with_index(&method_proc)
