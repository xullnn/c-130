# Letter                           Value
# A E I O U L N R S T       1
# D G                               2
# B C M P                         3
# F H V W Y                      4
# K                                  5
# J X                               8
# Q Z                               10

# SCORE_TABLE = {
#   %w(A E I O U L N R S T) => 1,
#   %w(D G) => 2,
#   %w(B C M P) => 3,
#   %w(F H V W Y) => 4,
#   %w(K) => 5,
#   %w(J X) => 8,
#   %w(Q Z) => 10,
# }

# PEDAC

# P
  # input: string
  # output: integer

  # given a word(string)
  # every character has a value
  # sum the values for every char
  # if empty str or not a str => 0
  # if one or more spaces or new line character => 0
  # case insensitive

# E
  # Scrabble.new(nil).score
  # it has a Scabble class
  # it has an initialize method which takes the str
  # it has an instance method score which return integer score

# D
  # Hash
  # String
  # Array

# A
  # set score = 0
  # defend clause: return 0 if
    # non str or empty str
  # iterate through the chars one by one
    # iterate through Table
      # if the key.include? current char
      # increment total score by value
  #   end
  # end
  # return score

class Scrabble
  SCORE_TABLE = {
    %w(A E I O U L N R S T) => 1,
    %w(D G) => 2,
    %w(B C M P) => 3,
    %w(F H V W Y) => 4,
    %w(K) => 5,
    %w(J X) => 8,
    %w(Q Z) => 10,
  }

  def initialize(str)
    @string = str
  end

  def self.score(str)
    new(str).score
  end

  def score
    return 0 if !@string.is_a?(String) || @string.match(/[^\w]/) || @string.empty?
    score = 0
    @string.each_char do |char|
      SCORE_TABLE.each do |range, value|
        score += value if range.include?(char.upcase)
      end
    end
    score
  end
end
