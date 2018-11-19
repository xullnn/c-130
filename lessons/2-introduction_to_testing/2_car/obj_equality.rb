require 'minitest/autorun'

# class EqualityTest < Minitest::Test
#   def test_value_equality
#     str1 = 'hi there'
#     str2 = 'hi there'
#
#     assert_equal(str1, str2)
#     assert_same(str1, str2)
#   end
# end

class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end

  def ==(another)
    other.is_a?(Car) && name == another.name
  end
end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = 'Kim'
    car2.name = 'Kim'

    assert_equal(car1, car2)
  end
end
