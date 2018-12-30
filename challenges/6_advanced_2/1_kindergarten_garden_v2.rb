class Garden
  SEED_TO_PLANT = { 'G' => :grass, 'R' => :radishes, 'C' => :clover, 'V' => :violets }
  CHILDREN = %w[Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry]

  def initialize(rows, names = nil)
    @rows = rows.split("\n")
    @names = (names ? names.sort : CHILDREN).map(&:downcase)
    @pointers = generate_idx_indicator
    define_methods_for_names
  end

  def generate_idx_indicator
    i = 0
    @names.each_with_object(Hash.new) do |name, hash|
      hash[name] = i
      i += 2
    end
  end

  def get_plants(name)
    i = @pointers[name]
    @chars = @rows.map { |row| row[i, 2] }.join.split('')
    @chars.map { |c| SEED_TO_PLANT[c] }
  end

  def define_methods_for_names
    @names.each do |name|
      Garden.send(:define_method, name.to_sym) { get_plants(name) }
    end
  end
end
