# two row avaiable for planting
#   - for each row every child plant 2 of their 4 cups
#   - every line 24 cups(only if all children have planted 4 cups)
#
# 12 children
#   Alice, Bob, Charlie, David, # A B C D
#   Eve, Fred, Ginny, Harriet, # E F G H
#   Ileana, Joseph, Kincaid, and Larry.
#
#   - every one 4 cups, totally 48 cups
#   - cups in **alphabetical** order.
#
# - for type of seeds
#   - grass, clover, radishes, and violets.
#     - respectively represented by  G, C, R ,V in string
#
# input
#   - a two line string: "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV"
#   - a name of a child
# output
#   - all the plants the child planted
#     - an array of symbols: `[:radishes, :clover, :grass, :grass]`
#
# - build a char to plant hash table
#   - {'G' => :grass ... }
#
# - split input string into two string array
#   - ["VRCGVVRVCGGCCGVRGCVCGCGV", "VRCCCGCRRGVCGCRVVCVGCGCV"]
#
# - build a table, assign every child name with its starting index in the string
#   - {'Alic' => 0, 'Bob' => 2, 'Charlie' => 4 ... }
#
# - When calling garden.someones_name
#   - rewrite method_missing for Garden class
#   - if the sending name is on the hash
#       - get the starting index and take the corresponding two chars
#       - then lookup from the plant table
#   - if sending name is not on of the children's names
#     - call super

class Garden
  SEED_TO_PLANT = { 'G' => :grass, 'R' => :radishes, 'C' => :clover, 'V' => :violets }
  CHILDREN = %w[Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry]

  def initialize(rows, names = nil)
    @rows = rows.split("\n")
    @names = (names ? names.sort : CHILDREN).map(&:downcase)
    @pointers = generate_idx_indicator
  end

  def generate_idx_indicator
    i = 0
    @names.each_with_object(Hash.new) do |name, hash|
      hash[name] = i
      i += 2
    end
  end

  def method_missing(name)
    if @names.include?(name.to_s)
      i = @pointers[name.to_s]
      @chars = @rows.map { |row| row[i, 2] }.join.split('')
      @chars.map { |c| SEED_TO_PLANT[c] }
    else
      super
    end
  end
end
