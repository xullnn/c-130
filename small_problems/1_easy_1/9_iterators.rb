# 1
# def one?(collection)
#   counter = 0
#   collection.each { |item| counter += 1 if yield(item) }
#   counter == 1
# end

# 2
# def one?(collection)
#   result = false
#   collection.each do |item|
#     if result == false
#       result = true if yield(item)
#     else
#       return false if yield(item)
#     end
#   end
#   result
# end

p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
p one?([1, 3, 5, 7]) { |value| true }           # -> false
p one?([1, 3, 5, 7]) { |value| false }          # -> false
p one?([]) { |value| true }


# standard solution

# def one?(collection)
#   result = false
#   collection.each do |item|
#     next unless yield(item)
#     return false if result
#     result = true
#   end
#   result
# end
