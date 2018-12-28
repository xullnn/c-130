# class method:
#   - initialize: takes 3 sides
#   - where: takes possible 3 arugments(in a form of hash)
#     - max_factor(must have)
#     - min_factor
#     - sum
#     - return an array of Triplet objects
#       - all possble combinations
#
# instance methods:
#   - sum: sum up 3 sides
#   - product: claculate the product of the 3 sides
#   - pythagorean?: return boolean based on if the triangle is right triangle
#
#
# Algorithm
#   - pythagorean?
#     - long_side = sides.max
#     - others = sides - [long_side]
#     - long_side ** 2 == others.reduce { |a, b| a ** 2 + b ** 2 }
#
#   - sum: sides.sum
#   - product: sides.reduce(&:*)
#
#   - Triplet::Where
#     - default min_factor: 1
#     - find all 3 sides combinations from min_factor to max_factor
#     - select all pythagorean?
#       - if sum is given? add additional condition

class Triplet
  def initialize(*sides)
    @sides = sides
  end

  def sum
    @sides.sum
  end

  def product
    @sides.reduce(&:*)
  end

  def pythagorean?
    long_side = @sides.max
    others = @sides - [long_side]
    long_side**2 == others.reduce { |a, b| a**2 + b**2 }
  end

  def self.where(min_factor: 1, max_factor:, sum: nil)
    (min_factor..max_factor).to_a.combination(3).each_with_object([]) do |sides, arr|
      triplet = Triplet.new(*sides)
      next if !triplet.pythagorean? || (sum && triplet.sum != sum)
      arr << triplet
    end
  end
end
