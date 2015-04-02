require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def create_tasks(num)
    num.times do |x|
      TaskManager.create({ title: "My task#{x+1}", description: "something#{x+1}"})
    end
  end

  def test_can_create_a_task_with_an_id
    #pass a title and a description to taskmanager create
    #assert that we can find a task with id
    #assert that it assigned correct title and desd
    TaskManager.create({ title: "my task",
                         description: "something"})
    task = TaskManager.find(1)
    assert_equal "my task", task.title
    assert_equal "something", task.description
    assert_equal 1, task.id
  end

  def test_it_can_destroy_a_task
    create_tasks(3)
    assert_equal 3, TaskManager.all.size
    TaskManager.destroy(1)
    assert_equal 2, TaskManager.all.size
  end

  def test_it_returns_all_tasks
    create_tasks(5)
    tasks = TaskManager.all
    assert_equal 5, tasks.size
    assert_equal Task, tasks[0].class
  end

  def test_it_can_find_a_specific_task
    create_tasks(3)
    task = TaskManager.find(2)
    assert_equal 2, task.id
    assert_equal "My task2", task.title
    assert_equal "something2", task.description
  end

  def test_it_can_update_a_task
    create_tasks(1)
    task = TaskManager.find(1)
    assert_equal "My task1", task.title

  end
end












