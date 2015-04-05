require_relative '../test_helper'

class UserEditsTaskTest < FeatureTest
  def test_edit_title_and_description
    TaskManager.create({ title: "Learn",
                         description: "today"})
    visit '/tasks'

    click_link_or_button("Edit")
    fill_in("task[title]", with: "Learn Pry")
    fill_in("task[description]", with: "now")
    click_link_or_button("submit-edit")

    last_path = TaskManager.all.last.id
    assert_equal "/tasks/#{last_path}", current_path
    within("#show") do
      assert page.has_content?("Pry")
      assert page.has_content?("now")
    end
  end
end
