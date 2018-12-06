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
  def size
    size = 0
    e = @head
    while e
      size += 1
      e = e.next
    end
    size
  end

  def empty?
    @head.nil?
  end

  def push(num)
    new_element = Element.new(num)
    new_element.next = @head if !empty?
    @head = new_element
    self
  end

  def peek
    empty? ? nil : head.datum
  end

  def head
    @head
  end

  def pop
    old_head = @head
    @head = @head.next
    old_head.datum
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
    return [] unless @head
    e = @head
    arr = [e.datum]
    while e.next
      arr << e.next.datum
      e = e.next
    end
    arr
  end

  def reverse
    e = @head
    new_list = SimpleLinkedList.new.push(e.datum)
    while e.next
      new_list.push(e.next.datum)
      e = e.next
    end
    new_list
  end
end
