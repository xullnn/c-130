require 'minitest/autorun'
require './todo_list.rb'
# require 'simplecov'
# SimpleCov.start

class TestTodoList < MiniTest::Test
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_adding_wrong_type
    non_todo = 'item'
    assert_raises(TypeError) { @list.add(non_todo) }
  end

  def test_shovel
    new_item = Todo.new('new todo')
    @list << new_item
    assert_equal(4, @list.size)
    assert_equal(new_item, @list.last)
  end

  def test_add
    new_item = Todo.new('new todo')
    @list.add new_item
    assert_equal(4, @list.size)
    assert_equal(new_item, @list.last)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_mark_done_at
    assert_equal(false, @list.first.done?)
    @list.mark_done_at(0)
    assert_equal(true, @list.first.done?)
    assert_equal(false, @list.item_at(1).done?)
    assert_equal(false, @list.item_at(2).done?)
  end

  def test_done!
    assert_equal(true, @todos.none?(&:done?))
    @list.done!
    assert_equal(true, @todos.all?(&:done?))
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(3) }
    deleted = @list.remove_at(2)
    assert_equal(deleted, @todo3)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_to_s
    expected_str = <<~OUTPUT.strip
      ---- Today's Todos ----
      [ ] Buy milk
      [ ] Clean room
      [ ] Go to gym
    OUTPUT
    assert_equal(expected_str, @list.to_s)
  end

  def test_to_s_with_done
    expected_str = <<~OUTPUT.strip
      ---- Today's Todos ----
      [X] Buy milk
      [ ] Clean room
      [ ] Go to gym
    OUTPUT
    @list.mark_done_at(0)
    assert_equal(expected_str, @list.to_s)
  end

  def test_each
    i = 0
    @list.each do |item|
      assert_equal(@todos[i], item)
      i += 1
    end
  end

  def test_each_return
    returned = @list.each { |item| item.inspect }
    assert_equal(returned, @list)
  end

  def test_select
    selected = @list.select { |item| item.title == 'Buy milk' }
    refute_equal(@list, selected)
    assert_instance_of(TodoList, selected)
    assert_equal(@todo1, selected.first)
  end
end
