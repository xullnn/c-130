# reduce

# def reduce(collection, start = nil)
#   if start
#     index = 0
#     first = start
#     while index < collection.size
#       first = yield(first, collection[index])
#       index += 1
#     end
#   else
#     index = 1
#     first = collection.first
#     while index < collection.size
#       first = yield(first, collection[index])
#       index += 1
#     end
#   end
#   return first
# end

# def reduce(collection, start = nil)
#   if start
#     index = 0
#     first = start
#   else
#     index = 1
#     first = collection.first
#   end
#   while index < collection.size
#     first = yield(first, collection[index])
#     index += 1
#   end
#   return first
# end

def reduce(collection, start = nil)
  if start
    if start.is_a?(Symbol)
      rasei LocalJumpError, 'Extra blocks.' if block_given?
      enumerator = collection.each
      first = enumerator.next
      (collection.size - 1).times do
        first = first.send(start, enumerator.next)
      end
      return first
    else
      index = 0
      first = start
    end
  else
    index = 1
    first = collection.first
  end
  while index < collection.size
    first = yield(first, collection[index])
    index += 1
  end
  return first
end

arr = (2..5).to_a

p reduce(arr, :+)
