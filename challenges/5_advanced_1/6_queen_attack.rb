# input:
#   - white and black
#     - has an array as its location inside the coordinates
#   - board
#     - multiple line string
#       - underscore
#       - W B inserted based on give coordinates
#
#   - to_s method can draw out the board with B and W init
#   - attack? can determine whether the queen can attack the other

# Algorithm
#   - initialize
#     - validate two can not in the same place
#     - default coordinates
#       - [0, 3], queens.white
#       - [7, 3], queens.black
#
#   - to_s
#     - generate a 8 line string with W B and _
#       - nested map (0..7) to get current x,y
#         - if x,y == given B or W's coordinates, draw out
#         - otherwise, fill underscore
#       - join inner map
#       - join outer map with new line char
#
#   - attack
#     - x or y are same? OR
#     - |x1 - x2| == |y1 - y2|

class Queens
  attr_reader :white, :black

  def initialize(white: [0, 3], black: [7, 3])
    validate_locations(white, black)
    @white, @black = white, black
  end

  def to_s
    (0..7).to_a.map do |x|
      (0..7).to_a.map do |y|
        if [x, y] == white then 'W'
        elsif [x, y] == black then 'B'
        else '_'
        end
      end.join(' ')
    end.join("\n")
  end

  def attack?
    x1, y1, x2, y2 = white[0], white[1], black[0], black[1]
    x1 == x2 || y1 == y2 || (x1 - x2).abs == (y1 - y2).abs
  end

  private

  def validate_locations(white, black)
    raise ArgumentError if white == black
  end
end
