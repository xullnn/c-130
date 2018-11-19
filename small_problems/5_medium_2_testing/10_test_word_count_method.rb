class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end

  def word_count
    @text.split.count
  end
end

require 'minitest/autorun'

class TextTest < Minitest::Test
  def setup
    @file = File.open('./sample.txt', 'r')
    @string = @file.read
    @text_obj = Text.new(@string)
  end

  def test_word_count
    count = @string.scan(/\s{1}/).count
    assert_equal(count, @text_obj.word_count)
  end

  def teardown
    @file.close
    puts "File closed? #{@file.closed?}"
  end
end
