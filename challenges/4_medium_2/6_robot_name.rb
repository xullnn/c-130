class Robot
  @@ord = 0
  def initialize
    reset
  end

  def reset
    @@ord += 1
    @name = generate_new_name
  end

  def name
    @name
  end

  def generate_new_name
    s1 = ('A'..'Z').to_a.sample + ('A'..'Z').to_a.sample
    s2 = (0..9).map { |n| n ** @@ord }.shuffle.join[0,3]
    s1 + s2
  end
end
