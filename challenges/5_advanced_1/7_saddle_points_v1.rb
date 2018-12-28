class Matrix
  attr_reader :rows

  def initialize(str)
    @rows = str.split("\n").map { |line| line.split(' ').map(&:to_i) }
  end

  def columns
    (0..rows.first.size - 1).map { |col_idx| rows.map { |row| row[col_idx] } }
  end

  def saddle_points
    rows.map.with_index do |nums, y|
      nums.map.with_index do |num, x|
        [y, x] if nums.max == num && columns[x].min == num
      end
    end.flatten(1).compact
  end
end
