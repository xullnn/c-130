# class CircularBuffer
  # class methods:
    # new which takes the number of slot for the buffer
  # instance methods:
    # read pop out the oldest
    # write inject new element in
      # nil cannot be write in(also for write!)
    # write!
      # when has available slots, behaves like normal write
      # when full, first clear out the oldest, then do write
      # clear, delete all elements

  # Exceptions
    # CircularBuffer::BufferEmptyException
      # raised when read from empty buffer
    # CircularBuffer::BufferFullException
      # raised when write to full buffer

# D
  # Array

# A
  # encapsulate an array into instance variable
  # when write, always do unshift
  # when read, pop
  # encapsulate write's logic into write!

class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(num_of_slot)
    @num_of_slot = num_of_slot
    @buffer = []
  end

  def read
    raise BufferEmptyException unless @buffer.any?
    @buffer.pop
  end

  def write(element)
    raise BufferFullException if full?
    @buffer.prepend(element) unless element.nil?
  end

  def write!(element)
    return unless element
    read if full?
    write(element)
  end

  def clear
    @buffer = []
  end

  private

  def full?
    @buffer.size == @num_of_slot
  end
end
