# PEDAC

# P
  # count how many positions has the different letters
    # always use the shorter one as the standard
    # extra letters shoule be ignored(but not deleted)

  # input two strings
  # output integer

# E
  # it has a class DNA
  # it has an initialize method takes a string
  # it has a hamming_distance method which return the hamming distance
  #

# D
  # string
  # integer

  # switch the standard string based on their lengths

# A
  # set a manual index to 0
  # set the count = 0
    # then go throught the two strings simultaneously
    # if for current index any of either string has no corresponding letter, counting end
    # otherwise count += 1 if the tow letters are not the same
    # increment the index by 1
  # return the count

class DNA
  def initialize(target_segment)
    @target_segment = target_segment
  end

  def hamming_distance(other_segment)
    index, count = 0, 0
    loop do
      break unless @target_segment[index] && other_segment[index] # continue counting only when the two strings all have valid letters at same position
      count += 1 if @target_segment[index] != other_segment[index]
      index += 1
    end
    count
  end
end
