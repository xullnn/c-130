# def reduce(arr, start = nil)
#   # decide a starting object
#   # if second argument was given
#     # first block parameter would be the given one
#     # the first parameter would be the second element in the array
#   # if second argument was not given
#     # first block parameter would be the first element in the array
#     # the second parameter would be the second element in the array
#   if start # given the second argument
#     idx = 0
#     while idx < arr.size
#       returned = yield(start, arr[idx])
#       idx += 1
#       start = returned
#     end
#     start
#   else
#     idx = 0
#     start = arr.first
#     while idx < arr.size - 1
#       returned = yield(start, arr[idx + 1])
#       idx += 1
#       start = returned
#     end
#     start
#   end
# end

# def reduce(arr, start = nil)
#   if start # given the second argument
#     idx = 0
#     while idx < arr.size
#       returned = yield(start, arr[idx])
#       idx += 1
#       start = returned
#     end
#     start
#   else
#     idx = 0
#     start = arr.first
#     while idx < arr.size - 1
#       returned = yield(start, arr[idx + 1])
#       idx += 1
#       start = returned
#     end
#     start
#   end
# end


def reduce(arr, starting_obj = nil)
  if starting_obj
    idx = 0
  else
    starting_obj = arr.first
    idx = 1
  end

  while idx < arr.size
    returned = yield(starting_obj, arr[idx])
    idx += 1
    starting_obj = returned
  end

  starting_obj
end


array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
# p reduce(array) { |acc, num| acc + num if num.odd? }  # => NoMethodError: undefined method `+' for nil:NilClass

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # [1, 2, 'a', 'b']
