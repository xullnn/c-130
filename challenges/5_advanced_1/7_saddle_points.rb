# - saddle points
#   - when a number is the max in its row and the smallest in its column
#
# - input: multipe line string
# - output: nested array which contains all the saddle points coordinates
#   - [[0, 1], [1, 1], [2, 1]]

# ("1 2 3\n4 5 6\n7 8 9\n8 7 6")
# =>
# # [
# #   [1, 2, 3],
# #   [4, 5, 6],
# #   [7, 8 ,9],
# #   [8, 7, 6]
# # ]
# if output is [[0, 1], [1, 1], [2, 1]]
#   it points to 1, 4, 7
#
# 3, 6, 9, 8
#
# 1, 2, 3


# Algorithm
#
# - splite by \n, then split by ' ' then to_i
# - nested map through numbers
#   - generate a hash
#     - key: coordinates
#     - value: the value
#
# - go through numbers line by line(row)
#   - pick all the max value per line
# - go through numbers column by column
#   - pick all the min value per column
# - intersection the maxes and mins

class Matrix
  attr_reader :rows

  def initialize(str)
    @rows = str.split("\n").map do |line|
      line.split(' ').map(&:to_i)
    end
  end

  def columns
    (0..rows.size - 1).map do |col_idx|
      rows.map { |row| row[col_idx] }
    end
  end

  def hashilize_matrix
    hash = {}
    rows.each_with_index do |nums, x|
      nums.each.with_index do |num, y|
        hash[[x, y]] = num
      end
    end
    hash
  end

  def saddle_points
    maxes_per_row = rows.map { |nums| nums.max }
    mins_per_column = columns.map { |nums| nums.min }
    x = maxes_per_row.map.with_index do |max, line|
      hashilize_matrix.select { |coor, num| coor[0] == line && num == max }.keys
    end.flatten(1)
    y = mins_per_column.map.with_index do |min, col|
      hashilize_matrix.select { |coor, num| coor[1] == col && num == min }.keys
    end.flatten(1)
    x & y
  end
end
