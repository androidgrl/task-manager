require 'byebug'

class TaskManager

  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager_development.sqlite3")
    end
  end

  def self.create(task)
    data = {"title" => task[:title], "description" => task[:description]}
    database.from(:tasks).insert(data)
  end

  def self.all
    database.from(:tasks).all.map do |raw_task|
      Task.new(raw_task)
    end
  end

  def self.find(id)
    raw_task = dataset.from(:tasks).where(id: id).first
    Task.new(raw_task)
  end


  def self.update(id, task)
    database.from(:tasks).where(id: id).update(title: task[:title],
                                         description: task[:description])
  end

  def self.destroy(id)
    database.from(:tasks).where(id: id).delete
  end


  def self.delete_all
    database.from(:tasks).delete
  end

  def self.dataset
    database.from(:tasks)
  end
end

