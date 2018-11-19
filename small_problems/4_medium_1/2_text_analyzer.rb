class TextAnalyzer
  def process
    File.open(yield, 'r') do |f|
      text = f.read
      paragraphs = text.scan(/\n\n/).size + 1
      lines = text.scan(/\n/).size
      words = text.scan(/[\s+]/).size + 1 - paragraphs
      puts ["#{paragraphs} paragraphs", "#{lines} lines", "#{words} words"]
    end
  end
end

analyzer = TextAnalyzer.new
analyzer.process {'sample.txt'}
analyzer.process {'sample_1.txt'}
File.open('sample.txt', 'r'){ |f| f.read}

# standard solution
# just let process pass text object to the passed in block
# class TextAnalyzer
#   def process
#     File.open('sample.txt', 'r') { |f| yield(f.read) }
#   end
# end
# analyzer = TextAnalyzer.new
# analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
# analyzer.process { |text| puts "#{text.split("\n").count} lines" }
# analyzer.process { |text| puts "#{text.split(' ').count} words" }
