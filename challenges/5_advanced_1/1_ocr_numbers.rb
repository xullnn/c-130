#   _  _     _  _  _  _  _  _
# | _| _||_||_ |_   ||_||_|| |
# ||_  _|  | _||_|  ||_| _||_|

# how to represent a number
#   mulitple line string?
#   for every number:
#       - horizontally:  it takes 3 chars space
#       - vertically: it taks 4 chars space(the last line is always empty line)
#
# # Algorithm
#   use here doc to capture every ocr number, orderly store them into an array
#   fetch them by `Array#index()` method

class OCR
  SOCR = <<~MSG
   _     _  _     _  _  _  _  _
  | |  | _| _||_||_ |_   ||_||_|
  |_|  ||_  _|  | _||_|  ||_| _|

  MSG

  def self.extract_ocrs(ocr_str)
    lines = ocr_str.split("\n").map do |line|
      chars = line == '' ? [""] : line.chars # avoid "".chars to produce [], further call of each_slice(3).map(&:join) will return [] too, this will affect `zip` method later
      chars.each_slice(3).map(&:join)
    end
    nums = lines[0].zip(lines[1], lines[2]).map do |pieces|
      pieces.each(&:rstrip!)
    end
    nums.map { |num| num.join("\n") + "\n" }
  end

  NUMS = extract_ocrs(SOCR)

  def initialize(text)
    @text = text
  end

  def convert
    @text.split("\n\n").map do |line|
      convert_line(line)
    end.join(",")
  end

  def convert_line(line)
    possible_num_strs = OCR.extract_ocrs(line)
    possible_num_strs.map do |p_ocr|
      num = NUMS.index(p_ocr)
      num ? num.to_s : '?'
    end.join
  end
end
