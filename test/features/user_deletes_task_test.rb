require_relative '../test_helper'

class UserDeletesTaskTest < FeatureTest
  def test_delete_task
    TaskManager.create({ title: "Learn Pry",
                         description: "today"})
    visit '/tasks'

    click_link_or_button("delete")

    assert_equal '/tasks', current_path
    refute page.has_content?("Learn Pry")
 end
end
