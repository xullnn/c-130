# original version

# def bubble_sort!(array)
#   times = (1..(array.size - 1)).to_a
#   loop do
#     swapped = 0
#     times.pop.to_i.times do |a|
#       b = a + 1
#       if array[a] > array[b]
#         array[b], array[a] = array[a,2]
#         swapped += 1
#       end
#     end
#   return array if swapped == 0
#   end
# end

# What is the previous swapping criterion
  # if first > second

# What now if we add a optional block
  # first we would pass the two comparing obejcts to the block
    # these 2 passed in object will be captured by the blcok paramenters
  # then in the block
    # if we perform first > second then it actually is the same as before
    # if we perform first < second or second > first
      # we reverse the sorting order
    # so no matter what the performances would be excecuted in the block
    # we just care about the boolean value of the block returned
  # so if the block returns true
    # then we do the swap
  # else
    # no swapping

def bubble_sort!(array)
  times = (1..(array.size - 1)).to_a
  loop do
    swapped = 0
    times.pop.to_i.times do |a|
      b = a + 1
      if block_given?
        next if yield(array[a], array[b])
        array[b], array[a] = array[a,2]
        swapped += 1
      elsif array[a] > array[b]
        array[b], array[a] = array[a,2]
        swapped += 1
      end
    end
  return array if swapped == 0
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

def bubble_sort!(array)
  times = (1..(array.size - 1)).to_a
  loop do
    swapped = 0
    times.pop.to_i.times do |a|
      b = a + 1
      if block_given?
        next if yield(array[a]) < yield(array[b])
      else
        next if array[a] < array[b]
      end
      array[b], array[a] = array[a,2]
      swapped += 1
    end
  return array if swapped == 0
  end
end

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)


# def bubble_sort!(arr)
#   swapped = true
#   while swapped
#     swapped = false
#     (arr.size - 1).times do |i|
#       if block_given?
#         next if yield(arr[i]) <= yield(arr[i+1])
#       else
#         next if arr[i] < arr[i + 1]
#       end
#       arr[i], arr[i + 1] = arr[i + 1], arr[i]
#       swapped = true
#     end
#   end
# end
#
# array = %w(sue Pete alice Tyler rachel Kim bonnie)
# bubble_sort!(array) { |value| value.downcase }
# p array == %w(alice bonnie Kim Pete rachel sue Tyler)
