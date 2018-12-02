# RNA a series of condons
# codon: three nucleotide as a coding unit
# Protein: protein translated from a codon

# table
TRANS_TABLE = {
  %w(AUG)	               => "Methionine",
  %w(UUU, UUC)	         => "Phenylalanine",
  %w(UUA, UUG)	         => "Leucine",
  %w(UCU, UCC, UCA, UCG) => "Serine",
  %w(UAU, UAC)	         => "Tyrosine",
  %w(UGU, UGC)	         => "Cysteine",
  %w(UGG)	               => "Tryptophan",
  %w(UAA, UAG, UGA)	     => "STOP"
}

# E
  # class Translation
  # class method of_codon takes single codon return single protein
  # class method of_rna takes a strand of RNA return an array of proteins
  # invlaid input RNA should raise InvalidCodonError

# D
  # String
  # Array
  # Hash

# A
  # validate: strand.match /[^atug]/i is invalid
  # of_codon
    # go through the table match the keys

  # of rna
    # split strand into codons
    # go through the codons
      # if return value from of_codon is not 'stop'
      #   push it into list
      # else
      #   break
      # end return the list

class InvalidCodonError < StandardError; end

module Translation
  TRANS_TABLE = {
    %w(AUG)	            => "Methionine",
    %w(UUU UUC)	        => "Phenylalanine",
    %w(UUA UUG)	        => "Leucine",
    %w(UCU UCC UCA UCG) => "Serine",
    %w(UAU UAC)	        => "Tyrosine",
    %w(UGU UGC)	        => "Cysteine",
    %w(UGG)	            => "Tryptophan",
    %w(UAA UAG UGA)	    => "STOP"
  }

  def self.of_codon(codon)
    raise InvalidCodonError if codon.match /[^ACUG]/
    TRANS_TABLE.each { |codons, protein| return protein if codons.include?(codon) }
  end

  def self.of_rna(strand)
    codons = strand.scan(/.../)
    codons.reduce([]) do |proteins, codon|
      return proteins if of_codon(codon) == 'STOP'
      proteins << of_codon(codon)
    end
  end
end
