require 'yaml/store'
require 'sequel'

class TaskManager

  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= YAML::Store.new("db/task_manager_test")
      #@database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= YAML::Store.new("db/task_manager_development")
      #@database ||= Sequel.sqlite("db/task_manager_development.sqlite3")
    end
  end

  def self.create(task)
    #data = {"title" => task[:title], "description" => task[:description]}
    #database.from(:tasks).insert(data)
    #delete below
    database.transaction do
      database['tasks'] ||= []
      database['total'] ||= 0
      database['total'] += 1
      database['tasks'] << { "id" => database['total'], "title" => task[:title], "description" => task[:description] }
    end
  end

  def self.raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def self.all
    #go to task class and change strings to symbols
    #and we had problem from commented delete all
    #database.from(:tasks).all.map do |raw_task|
    #Task.new(raw_task)
    #end
    #delete below which returns an array
    raw_tasks.map { |data| Task.new(data) }
  end

  def self.raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def self.find(id)
    #raw_task= database.from(:tasks).where(:id => id).to_a.first
    #we want to send back a task now were getting an array
    #calling first gives us a hash
    #Task.new(raw_task)
  end


  def self.update(id, task)
    database.transaction do
      target = database['tasks'].find { |data| data["id"] == id }
      target["title"] = task[:title]
      target["description"] = task[:description]
    end
  end

  def self.destroy(id)
    database.transaction do
      database['tasks'].delete_if { |task| task["id"] == id }
    end
  end


  def self.delete_all
    #database.from(:tasks).delete
    #delete below

    database.transaction do
      database['tasks'] = []
      database['total'] = 0
    end
  end
end

