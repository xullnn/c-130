class House
  def self.recite
    new.generate_rhyme
  end

  def generate_rhyme
    (0..pieces.size - 1).map { |from_index| generate_pharagraph(from_index)}.reverse.join("\n")
  end

  def generate_pharagraph(from_index)
    sentences = ["This is #{pieces[from_index .. -1][0][0]}"]
    pieces[from_index .. -1].each_cons(2) do |s1, s2|
      sentences << "#{s1[1]} #{s2[0]}" unless s1.empty?
    end
    sentences.join("\n") + ".\n"
  end

  private

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
