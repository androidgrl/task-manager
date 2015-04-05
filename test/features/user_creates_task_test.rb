require_relative '../test_helper'

class UserCreatesTaskTest < FeatureTest
  def test_create_task_with_title_and_description
    visit '/'
    click_link_or_button("New Task")

    fill_in("task[title]", with: "Make cookies")
    fill_in("task[description]", with: "now")
    click_link_or_button("Create task")

    assert_equal '/tasks', current_path
    within("#list") do
      assert page.has_content?("Make cookies")
    end
  end
end
