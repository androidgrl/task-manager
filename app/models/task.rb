class Task
  attr_reader :title,
              :description,
              :id

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @description = data[:description]
  end
#change the test to use symbols
end
