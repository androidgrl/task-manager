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
    fill_in("task[title]", with: "Learn Pry")
    #and i enter description with --
    fill_in("task[description]", with: "now")
    #and i click submit
    click_link_or_button("submit-edit")
    #then i will see the new task title and description
    assert_equal '/tasks/1', current_path
    assert page.has_content?("Learn Pry")
    #in the show page

  end
end
