class House
  def self.recite
    new.generate_rhyme
  end

  def initialize
    @full_rhyme = []
  end

  def generate_rhyme(from_index = 0)
    rhyme = generate_pharagraph(from_index)
    @full_rhyme.prepend(rhyme)
    from_index += 1
    if from_index <= pieces.size - 1
      generate_rhyme(from_index)
    else
      @full_rhyme.join("\n")
    end
  end

  def generate_pharagraph(index)
    arr = pieces[index .. -1]
    sentences = ["This is #{arr.first.first}"]
    arr.each_cons(2).with_index do |(s1, s2), i|
      break if i >= arr.size - 1
      sentences << "#{s1[1]} #{s2[0]}"
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

puts House.recite
