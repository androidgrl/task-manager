require_relative '../test_helper'

class UserDeletesTaskTest < FeatureTest
  def test_delete_task
    TaskManager.create({ title: "Learn Pry",
                         description: "today"})
    #as a guest when i visit the index page
    visit '/tasks'
    #and i click on delete button
    click_link_or_button("delete")
    #then i will see the index page again without the
    #task in it
    assert_equal '/tasks', current_path
    refute page.has_content?("Learn Pry")
 end
end
