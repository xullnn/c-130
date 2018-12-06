module RunLengthEncoding
  def self.encode(string)
    string.gsub(/(.)\1+/) { |m| "#{m.size}#{m[0]}" }
  end

  def self.decode(string)
    string.gsub(/(\d+\D)/) { |m| m[-1] * m[0..-2].to_i}
  end

  def self.counts_to_str(count)
    count == 1 ? '' : count.to_s
  end
end
