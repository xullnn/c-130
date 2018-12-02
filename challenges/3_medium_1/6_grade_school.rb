# class School
  # class methods:
    # new
  # instance methods:
    # to_h returns a hash use grades as keys and students as values
      # all should be sorted
    # add(student name, its grade)

# D
  # String
  # Array
  # Integer

# A
  # ::new
    # @students_info = {}
  # to_h return @students_info
  # add @students_info[grade] = name

  # But how to keep the order right?
  # for array: push and sort!?
  # for hash's order: hash.sort.to_h

class School
  def initialize
    @students_info = Hash.new([])
  end

  def add(name, grade)
    @students_info[grade] += [name]
    @students_info[grade].sort!
  end

  def to_h
    @students_info.sort.to_h
  end

  def grade(number)
    @students_info[number]
  end
end
