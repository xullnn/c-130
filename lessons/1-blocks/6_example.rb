def compare(str, flag)
  after = case flag
  when :upcase
    str.upcase
  when :capitalize
    str.capitalize
  end

  puts "Before #{str}"
  puts "After #{after}"
end

compare('hello', :upcase)
