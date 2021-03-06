class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo_item)
    if todo_item.is_a?(Todo)
      @todos << todo_item
      self
    else
      raise TypeError, "Can you add Todo objects?"
    end
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def valid_idx?(idx)
    (0..(@todos.size - 1)).include?(idx)
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    @todos[idx].done!
  end

  def mark_undone_at(idx)
    @todos[idx].undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    @todos.delete(@todos[idx])
  end

  def to_s
    str = "---- #{title} ----\n"
    @todos.each { |item| str << item.to_s + "\n" }
    str
  end

  def to_a
    @todos.to_a
  end

  def done?
    @todos.all? { |item| item.done? }
  end

  def each
    idx = 0
    if block_given?
      while idx < @todos.size
        yield(@todos[idx])
        idx += 1
      end
    end
    self
  end

  def select
    selected_list = TodoList.new("Today's Todos")
    self.each { |item| selected_list.add(item) if yield(item) }
    selected_list
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect
