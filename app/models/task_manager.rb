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

 #def self.raw_tasks
    #database.transaction do
      #database['tasks'] || []
    #end
  #end

  def self.all
    #go to task class and change strings to symbols
    #and we had problem from commented delete all
    database.from(:tasks).all.map do |raw_task|
      Task.new(raw_task)
    end
    #delete below which returns an array
    #raw_tasks.map { |data| Task.new(data) }
  end

  #def self.raw_task(id)
    #raw_tasks.find { |task| task["id"] == id }
  #end

  def self.find(id)
   # raw_task = dataset.find(id).first
    raw_task = dataset.from(:tasks).where(id: id).first
    Task.new(raw_task)
    #raw_task = dataset.find(id).first use 49 and 53
    #raw_task= database.from(:tasks).where(id: id).to_a.first you can get rid of to_a first is a sequel thing
    #we want to send back a task now were getting an array
    #calling first gives us a hash
    #Task.new(raw_task)
  end


  def self.update(id, task)

    database.from(:tasks).where(id: id).update(title: task[:title],
                                         description: task[:description])

#    require 'pry'; binding.pry
    #database.transaction do
      #target = database['tasks'].find { |data| data["id"] == id }
      #target["title"] = task[:title]
      #target["description"] = task[:description]
    #end
  end

  def self.destroy(id)
    database.from(:tasks).where(id: id).delete
  end


  def self.delete_all
    database.from(:tasks).delete
#deletes rows from tables so that's why i don't have to run the migrate again
    #but when you first run the test you have to run from command line
    #database.transaction do
    #  database['tasks'] = []
    #  database['total'] = 0
    #end
  end
#this is new stuff from eric
  #now replace all instances of database.from(:tasks) with dataset
  def self.dataset
    database.from(:tasks)
  end
end

