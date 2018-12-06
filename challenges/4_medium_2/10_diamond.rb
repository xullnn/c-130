module Diamond
  def self.make_diamond(char)
    total_width = solid_string_width(char)
    make_solid_diamond(char).map do |string|
      let_string_hollow(string).center(total_width) + "\n"
    end.join
  end

  def self.solid_string_width(char)
    (char.ord - 64) * 2 - 1
  end

  def self.make_solid_diamond(char, arr = [], current = 'A')
    if current != char
      arr << current * solid_string_width(current)
      make_solid_diamond(char, arr, current = current.next)
    else
      arr + [char * solid_string_width(char)] + arr.reverse
    end
  end

  def self.let_string_hollow(string)
    return string if string.size == 1
    "#{string[0]}#{' ' * (string.length - 2)}#{string[0]}"
  end
end


# def make_solid_diamond(char, arr = [], current = 'A')
#   if current != char
#     arr << current * ((current.ord - 64) * 2 - 1)
#     make_upper_diamond(char, arr, current = current.next)
#   else
#     arr + [char * ((char.ord - 64) * 2 - 1)] + arr.reverse
#   end
# end




# handle the diamond in three parts
#   upper part
#   central line
#   reversed upper part
#
# if we have
#
#   A
#   AAA
#   AAAAA
#
# how to eliminate the centeral chars, leave only the edge chars?
#   string[1, string.size -2] = ' ' * string.size -2
#
# what's the width for every line?
#   A1 B3 C5
#   (char.ord - A.ord) * 2 + 1
#
# build the upper part
#   from A to (char.ord - 1).chr
#   no spaces
#   A * 1
#   B * 3
#   C * 5
#   ...
#
#   map
#   spoon out the central part
#   chars.let_string_hollow.center(width)
