# find out the vertical period of moving
  # - n = 5: 01234321
  # - n = 3: 01232
# call cycle on the vertical period so we don't have to concern how
# many periods we need, we just call `next` whenever we need one

# make an nested array as container which has n empty arrays in it
  # set a str.size times iteration, the blcok argument `ord` would be the ordinal
  # will be inserted(ord increment by 1 no matter we move up or down)
    # use vertical period indicator to determine which sub arr to insert
  # flatten the nested array then get the ordinals

class RailFenceCipher
  def self.encode(str, n)
    return str if n == 1 || n >= str.size
    ordinals = generate_ordinals(n, str)
    str.chars.values_at(*ordinals).join
  end

  def self.decode(str, n)
    return str if n == 1 || n >= str.size
    ordinals = generate_ordinals(n, str)
    ordinals.zip(str.chars).sort_by(&:first).map(&:last).join
  end

  def self.generate_ordinals(n, str)
    vertical_period = ((0..(n - 1)).to_a + (n - 2).downto(1).to_a).cycle
    numbers_on_rails = n.times.with_object([]) { |_, arr| arr << Array.new }
    str.size.times.with_object(numbers_on_rails) do |ord, nums|
      nums[vertical_period.next] << ord
    end.flatten
  end
end

p RailFenceCipher.encode(('A'..'Y').to_a.join, 5)
