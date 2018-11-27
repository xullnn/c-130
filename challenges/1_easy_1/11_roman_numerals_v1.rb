class Integer
  ROMAN_MARKS = %w(I V X L C D M)

  def to_roman
    index = 0
    str = ''
    digits.map do |digit|
      marks = ROMAN_MARKS[index,3]
      index += 2
      case
      when digit == 0 then ''
      when digit <= 3 then marks.first * digit
      when digit == 4 then marks.first + marks[1]
      when digit == 5 then marks[1]
      when digit > 5 && digit <= 8 then marks[1] + marks.first * (digit - 5)
      when digit == 9 then marks.first + marks.last
      end
    end.reverse.join

  end
end
