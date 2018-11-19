require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'todolist'


class TodoListTest < MiniTest::Test
  def setup
    @todo1 = Todo.new('Buy milk')
    @todo2 = Todo.new('Clean room')
    @todo3 = Todo.new('Go to gym')
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
    shifted = @list.shift
    assert_equal(@todo1, shifted)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    popped = @list.pop
    assert_equal(@todo3, popped)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    @list.each { |item| item.done! }
    assert_equal(true, @list.done?)
  end

  def test_add_wrong_type
    wrong_type = Object.new
    assert_raises(TypeError) do
      @list.add(wrong_type)
    end
  end

  def test_shovel
    right_type = Todo.new('test item')
    @list << right_type
    assert_instance_of(Todo, @list.last)
  end

  def test_add_alias
    item1 = Todo.new('test item1')
    item2 = Todo.new('test item2')
    @list.add(item1)
    @list << item2
    assert_equal(@list.last(2), [item1, item2])
  end

  def item_at
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_mark_done_at
    @list.mark_done_at(2)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_raises(IndexError) { @list.mark_done_at(3) }
  end

  def test_mark_undone_at
    @list.mark_all_done!
    @list.mark_undone_at(2)
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)

    assert_raises(IndexError) { @list.mark_undone_at(3) }
  end

  def test_mark_all_done!
    @list.mark_all_done!
    assert_equal(true, @todos.all? { |item| item.done? == true })
  end

  def test_remove_at
    @list.remove_at(0)
    assert_equal([@todo2, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(3) }
  end

  def test_to_s
    output = <<-MSG
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    MSG
    output.gsub!(/^\s+/, '')

    assert_equal(output, @list.to_s)
  end

  def test_to_s_with_one_done
    @todo1.done!
    output = <<-MSG
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    MSG
    output.gsub!(/^\s+/, '')

    assert_equal(output, @list.to_s)
  end

  def test_to_s_with_all_done
    @list.mark_all_done!
    output = <<-MSG
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    MSG
    output.gsub!(/^\s+/, '')

    assert_equal(output, @list.to_s)
  end

  def test_each
    idx = 0
    @list.each do |item|
      assert_same(@todos[idx], item)
      idx += 1
    end
  end

  def test_each_returns
    assert_equal(@list, @list.each{})
  end

  def test_select
    selected = @list.select { |item| item.title.match /Buy/ }
    assert_instance_of(TodoList, selected)
    assert_equal(1, selected.size)
    assert_equal(3, @list.size)
  end
end
