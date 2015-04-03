require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def create_tasks(num)
    num.times do |x|
      TaskManager.create({ title: "My task#{x+1}", description: "something#{x+1}"})
    end
  end

  def test_can_create_a_task_with_an_id
    TaskManager.create({ title: "my task",
                         description: "something"})
    last_task = TaskManager.all.last
    TaskManager.find(last_task.id)
    assert_equal "my task", last_task.title
    assert_equal "something", last_task.description
  end

  def test_it_can_destroy_a_task
    create_tasks(3)
    assert_equal 3, TaskManager.all.size
    last_task = TaskManager.all.last
    TaskManager.destroy(last_task.id)
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
    last_task = TaskManager.all.last
    TaskManager.find(last_task.id)
    assert_equal "My task3", last_task.title
    assert_equal "something3", last_task.description
  end

  def test_it_can_update_a_task
    create_tasks(1)
    last_task = TaskManager.all.last
    task = TaskManager.find(last_task.id)
    assert_equal "My task1", task.title

  end
end












