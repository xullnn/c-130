class Element
  attr_accessor :next

  def initialize(num, next_e = nil)
    @num = num
    @next = next_e
  end

  def datum
    @num
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  def initialize
    @elements = []
  end

  def size
    @elements.size
  end

  def empty?
    @elements.empty?
  end

  def push(num)
    new_element = Element.new(num)
    new_element.next = @elements.last if !empty?
    @elements << new_element
  end

  def peek
    empty? ? nil : head.datum
  end

  def head
    @elements.last
  end

  def pop
    @elements.pop.datum
  end

  def self.from_a(arr)
    collection = arr ? arr : []
    l = new
    collection.reverse.each do |datum|
      l.push(datum)
    end
    l
  end

  def to_a
    @elements.map { |e| e.datum }.reverse
  end

  def reverse
    @elements.each { |e| e.next = nil }
    @elements.reverse!.each_cons(2) { |a, b| b.next = a }
    self
  end
end
