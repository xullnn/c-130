class ValueError < StandardError; end

class Board
  def self.transform(inp)
    validate_input(inp)
    inp.map.with_index do |line, y|
      line.chars.map.with_index do |char, x|
        if char == ' '
          count = count_adjacent_mines(x, y, inp)
          count == 0 ? ' ' : count.to_s
        else
          char
        end
      end.join
    end
  end

  def self.count_adjacent_mines(x, y, inp)
    [x - 1, x, x + 1].product([y - 1, y, y + 1]).count { |a, b| inp[b][a] == '*' }
  end

  def self.validate_input(inp)
    raise ValueError if
      inp.any? do |line|
        line.size != inp.first.size ||
        line.match(/[^\+\-\s\*\|]/) ||
        line[0] != line[-1]
      end
  end
end
