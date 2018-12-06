# 1
# 1 1
# 1 2 1
# 1 3 3 1
# 1 4 6 4 1
# # ... etc

# [1] + [sum1, sum2] + [1]
# [1].each_cons(2).map(&:sum)

# input: integer
# output: nested array

# A

# set rows to [[1]]
#
# if given 1 return [[1]]
# if > 2
#   [1] + row.last_line.each_cons(2).map(&:sum) + [1]

class Triangle
  def initialize(num)
    @num = num
    @rows = [[1]]
  end

  def rows
    return @rows if @num == 1
    (@num - 1).times do
      current_row = [1] + central_part + [1]
      @rows << current_row
    end
    @rows
  end

  private

  def central_part
    @rows.last.each_cons(2).map(&:sum)
  end
end
