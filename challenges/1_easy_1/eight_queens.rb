# top down
# recursive

# ways to represent board

# nested array
  # p  (1..8).to_a.product((1..8).to_a)
  # [
  #   [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8],
  #   [2, 1], [2, 2], [2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [2, 8],
  #   [3, 1], [3, 2], [3, 3], [3, 4], [3, 5], [3, 6], [3, 7], [3, 8],
  #   [4, 1], [4, 2], [4, 3], [4, 4], [4, 5], [4, 6], [4, 7], [4, 8],
  #   [5, 1], [5, 2], [5, 3], [5, 4], [5, 5], [5, 6], [5, 7], [5, 8],
  #   [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7], [6, 8],
  #   [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7], [7, 8],
  #   [8, 1], [8, 2], [8, 3], [8, 4], [8, 5], [8, 6], [8, 7], [8, 8]
  # ]



# row = 8
# column = 1

# base case
  # no available cell ||
  #

# class Board
  # attr_reader :cells
  # Board.new(8,8)
    # @cells = (1..8).to_a.product((1..8).to_a)
#

# class Cell
# attr_reader :row, :column

# Brute
start_time = Time.new
all_cells = (1..8).to_a.product((1..8).to_a)
all_eight_combinations = all_cells.combination(8).to_a

class Array
  def cannot_kill(another)
    a,b = self.first, self.last
    x,y = another.first, another.last
    a != x && b != y && (a - x).abs != (b - y).abs
  end
end

# p [1,1].cannot_kill [1,3]
# p [1,1].cannot_kill [2,1]
# p [1,1].cannot_kill [2,2]
# p [1,1].cannot_kill [2,3]

solutions = 0
all_eight_combinations.each do |eight_queens|
  solutions += 1 if eight_queens.combination(2).to_a.all? { |pair| pair.first.cannot_kill(pair.last) }
end
p solutions

ending_time = Time.new
p duration = ending_time - start_time
puts "#{duration / 3600} hours "
