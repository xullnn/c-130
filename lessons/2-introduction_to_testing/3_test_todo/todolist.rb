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
  attr_accessor :title

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

  def last(n = 1)
    if n == 1
      @todos.last
    else
      @todos[-n, n]
    end
  end

  def valid_idx?(idx)
    (0..(@todos.size - 1)).include?(idx)
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    @todos.fetch(idx).done!
  end

  def mark_undone_at(idx)
    @todos.fetch(idx).undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    @todos.delete(@todos.fetch(idx))
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
    self.each { |item| selected_list.add(item.clone) if yield(item) }
    selected_list
  end

  def find_by_title(target)
    each do |item|
      return item if item.title.match(Regexp.new(target, true))
    end
    return nil
  end

  def all_done
    select { |item| item.done? }
  end

  def all_not_done
    select { |item| !item.done? }
  end

  def mark_done(target)
    find_by_title(target).done! if find_by_title(target)
  end

  def mark_all_done!
    each { |item| item.done! }
  end

  def mark_all_undone!
    each { |item| item.undone! }
  end
end
