require 'minitest/autorun'
require_relative '8_swap_letters_sample_text_and_starter_file'

class TextTest < Minitest::Test
  def setup
    @string = File.open('./sample.txt', 'r') { |f| f.read }
    @text_obj = Text.new(@string)
  end

  # def test_swap
  #   @plain_text = @plain_text.gsub('a', 'e')
  #   processed = @text_obj.swap('a', 'e')
  #   assert_equal(@plain_text, processed)
  # end

  def test_swap
    pre_as = @string.count('a')
    pre_es = @string.count('e')
    processed = @text_obj.swap('a', 'e')
    assert_equal(0, processed.count('a'))
    assert_equal(pre_as + pre_es, processed.count('e'))
  end
end
