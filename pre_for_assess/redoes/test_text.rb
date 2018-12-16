require 'minitest/autorun'
require './text.rb'

class TextTest < Minitest::Test
  def setup
    @file = File.open("./sample.txt")
    original_string = @file.read
    @text = Text.new(original_string)
    @expected_swapped = original_string.chars.map do |c|
      c == 'a' ? 'e' : c
    end.join
  end

  def test_swap
    assert_equal @expected_swapped, @text.swap('a', 'e')
  end

  def teardown
    @file.close
  end
end
