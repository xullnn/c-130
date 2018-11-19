# def find_break_index(collection, &block)
#   collection.each.with_index do |obj, idx|
#     return idx unless block.call(obj)
#   end
#   nil
# end
#
# def drop_while(collection, &block)
#   idx = find_break_index(collection, &block)
#   idx ? collection[idx..-1] : []
# end

# def drop_while(collection)
#   break_idx = collection.each.with_index do |obj, idx|
#     break idx unless yield(obj)
#   end
#   break_idx.is_a?(Integer) ? collection[break_idx..-1] : []
# end

# standard solution
#
# def drop_while(array)
#   index = 0
#   while index < array.size && yield(array[index])
#     index += 1
#   end
#
#   array[index..-1]
# end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []
