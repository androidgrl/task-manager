require_relative '../test_helper'

class UserCreatesTaskTest < FeatureTest
  def test_create_task_with_title_and_description
    #as a guest when i visit the root path
    visit '/'
    #and click on new task
    click_link_or_button("New Task")
    #and enter title with --
    fill_in("task[title]", with: "Make cookies")
    #and enter description with --
    fill_in("task[description]", with: "now")
    #and i click submit
    click_link_or_button("Create task")
    #need button to have value
    #then i will see the new task title and description
    assert_equal '/tasks', current_path
    within("#list") do
      assert page.has_content?("Make cookies")
    end
  end
end
