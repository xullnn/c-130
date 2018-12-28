# two parts
  # - box
  # - starts and countings

# what's adjacent?
  # - if in terms of coordinates
  #   - two terms distance is either 1 or square root of 2
  #     - distance: square root of (x1 - x2)**2 + (y1 - y2)**2

# How to give x,y?
  # - class Ceil
  #   - x, y
  #   - type: :space or :mine
  #
  # - scan all the valid space inside the string
  # - sub all chars as ceil objects
  #
  # - scan all ceil objects whose type is :mine
  #   - count adjacent mines
  #     - select :mines whose y is -1 this or + 1
  #     - calculate their distance
  #       - if it's 1 or sqrt 2, counting += 1
  #
  # - sub back ceil objects with star or counting

# how to extract avaiable string chars(strip the box)
  # - select \n and * and join?
  # - after scanning
  #   - sub that part back

class ValueError < StandardError; end

class Ceil
  attr_reader :type, :x, :y
  ADJ_DISTANCE = [1, Math.sqrt(2)]

  def initialize(x, y, type)
    @x, @y, @type = x, y, type
  end

  def distance_with(another)
    Math.sqrt((x - another.x)**2 + (y - another.y)**2)
  end

  def adjacent_mine?(another)
    another.type == :mine &&
      ((y - 1)..(y + 1)).cover?(another.y) &&
      ADJ_DISTANCE.include?(distance_with(another))
  end
end

class Board
  def self.transform(inp)
    validate_input(inp)
    stripped_str = inp[1..-2].map { |line| line.delete('|') }
    ceils = to_ceils(stripped_str)
    counted_strs = scan_and_count(ceils)
    inp[1..-2] = counted_strs.map { |line| "|#{line}|" }
    inp
  end

  def self.validate_input(inp)
    raise ValueError if
      inp.any? do |line|
        line.size != inp.first.size ||
        line.match(/[^\+\-\s\*\|]/) ||
        line[0] != line[-1]
      end
  end

  def self.scan_and_count(ceils)
    ceils.map do |line|
      line.map do |ceil|
        if ceil.type == :mine
          '*'
        else
          num = ceils.flatten.count { |c| ceil.adjacent_mine?(c) }
          num == 0 ? ' ' : num.to_s
        end
      end.join
    end
  end

  def self.to_ceils(stripped_str)
    stripped_str.map.with_index(1) do |line, y|
      line.chars.map.with_index(1) do |char, x|
        type = char == ' ' ? :space : :mine
        Ceil.new(x, y, type)
      end
    end
  end
end
