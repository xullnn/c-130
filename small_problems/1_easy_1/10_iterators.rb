# def count(collection)
#   count = 0
#   collection.each { |item| count += 1 if yield(item) }
#   count
# end

# don't use each while loop

def count(collection)
  collection.reduce(0) { |count, item| yield(item) ? count + 1 : count }
end


p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2
