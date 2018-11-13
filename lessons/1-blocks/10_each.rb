def each(arr)
  idx = 0
  while idx < arr.size
    yield(arr[idx])
    idx += 1
  end

  arr
end

arr = [1, 2, 3, 4, 5]

p each(arr) { |element| puts element }.select { |num| num.odd? }
