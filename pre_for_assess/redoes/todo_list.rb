require 'pry'
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

  def add(item)
    raise(TypeError, "Can only add Todo objects") if !item.is_a?(Todo)
    @todos << item
    self
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def to_a
    @todos.clone
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def done?
    @todos.all? { |item| item.done? }
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def done!
    @todos.each(&:done!)
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end

  def make_each_enum_for(collection)
    Enumerator.new do |y|
      i = 0
      while i < collection.size
        y << collection[i]
        i += 1
      end
    end
  end

  def each
    enumerator = make_each_enum_for(@todos)
    if block_given?
      size.times { yield(enumerator.next) }
    else
      return enumerator
    end
    self
  end

  def select
    new_list = TodoList.new(title)
    each do |item|
      new_list << item if yield(item)
    end
    new_list
  end

  def find_by_title(target)
    each do |item|
      return item if item.title == target
    end
    nil
  end

  def all_done
    select do |item|
      item.done?
    end
  end

  def all_not_done
    select do |item|
      !item.done?
    end
  end

  def mark_done(target)
    find_by_title(target).done!
    # find_by_title(title) && find_by_title(title).done!
  end

  def to_s
    str = "---- #{title} ----\n"
    str + @todos.map(&:to_s).join("\n")
  end

  def mark_all_done
    each { |item| item.done! }
  end

  def mark_all_undone
    each { |item| item.undone! }
  end
end
