require_relative '../test_helper'

class UserEditsTaskTest < FeatureTest
  def test_edit_title_and_description
    TaskManager.create({ title: "Learn",
                         description: "today"})
    #as a guest when i visit the index page
    visit '/tasks'
    #and i click on the edit button
    click_link_or_button("Edit")
    #and i enter a title with --
    save_and_open_page
    fill_in("task[title]", with: "Learn Pry")
    #and i enter description with --
    fill_in("task[description]", with: "now")
    #and i click submit
    click_link_or_button("submit-edit")
    #then i will see the new task title and description
    last_path = TaskManager.all.last.id
    assert_equal "/tasks/#{last_path}", current_path
    within("#show") do
      assert page.has_content?("Pry")
      assert page.has_content?("now")
    end
  end
end
