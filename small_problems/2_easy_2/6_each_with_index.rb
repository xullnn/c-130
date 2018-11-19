def each_with_index(collection)
  idx = 0
  collection.each { |obj| yield(obj, idx); idx += 1 }
  collection
end

result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]
