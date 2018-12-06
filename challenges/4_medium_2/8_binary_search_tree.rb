# # P
#   binary search tree is built from top to down
#   every node can seen as a Bst object
#     which has one + two instance variables
#       @data represents the value contained in this node
#       @left and @right represents the direct downstream two nodes(also Bst objects)
#
#   if inserting 1 value means
#     create a new Bst obj and set the @data of that object to the given numer
#     if the value is less than or equal to the current node's value, goes in @left of current node
#     otherwise if the value is greater than,  goes @right
#
#   if inserting 2 values
#     behave like inserting 1 value but 2 times
#     what if the given two values are all smaller than the current node?
#       this will build an extra layer, it means we don't have to fill both @right and @left for every root node
#       the scenario both two slots are filled is for the given two values, one is <= , and the other is >
#
#
#   if inserting >= 3 values
#     build nodes one layer by one layer
#     second layer
#       take the first two value, and follow the rule
#
#
#   how to extract the values from left to right from the tree
class Bst
  attr_reader :data, :left, :right

  def initialize(data)
    @data = data
  end

  def insert(value)
    if value <= data
      left.nil? ? @left = Bst.new(value) : left.insert(value)
    else
      right.nil? ? @right = Bst.new(value) : right.insert(value)
    end
  end

  def each(&block)
    return self.to_enum unless block_given?

    left.each(&block) if left
    yield(data)
    right.each(&block) if right
  end

end

# fisrt called on top node Bst(4)
# # left side tree
#   - left => true, each called on Bst(2)
#     - left => true, each called on Bst(1)
#       - left => false, go to second line yield(data) => yield(1)
#       - right => false, no more yielding
#   - yield(data) => yield(2)
#      - right => true, called each on Bst(3)
#      - left => false, yield(data) => yield(3)
#   - right => false, no more yielding
# # top node
#   - yield(data) => yield(4)
# #right side tree
#   - right => true, each called on Bst(6)
#     - left => true, each called on Bst(5)
#       - left => false, then yield(5)
#       - right => false, no more yielding
#   - yield(6)
#   - right => true, each called on Bst(7)
#      - left => false, yield(7)
#      - right => false, no more yielding





four = Bst.new 4
four.insert 2
four.insert 6
four.insert 1
four.insert 3
four.insert 7
four.insert 5

p four.each.take(3)
