require_relative '../../app/models/task_manager.rb'
#this makes a new database for each environment
#not a great solution but it works for now
#
environments = %w(development test)
environments.each do |env|
  Sequel.sqlite("db/task_manager_#{env}.sqlite3").create_table :tasks do
    primary_key :id
    String :title
    String :description
  end
end

#migrations set upl your schema, separate from your tests
#in line 6 and 7
#take out memoization from the other file, which is buggy so we only have to establish connection wiht db once
#ENV["TASK_MANAGER_ENV"] = env
#TaskManager.database.create_table :tasks do








