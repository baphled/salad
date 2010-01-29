When /^the first (.*) is hovered over$/ do |model|
  selenium.mouse_over("#{model}_1")
end

When /^the (.*) page is loaded$/ do |model|
  selenium.wait_for_element("#{model}_1")
end

When /^I press order$/ do
  selenium.click "order_icon"
end

When /^I press view features checkbox list$/ do
  selenium.click "features_checkbox", {:wait_for => :visible, :element => "fieldset_features"}
end

Then /^the project's information will be display in the sidebar$/ do
  selenium.wait_for_visible("project_1_features")
end

Then /^the story's information will be display in the sidebar$/ do
  selenium.wait_for_visible("story_1_steps")
end

Then /^the feature's information will be display in the sidebar$/ do
  selenium.wait_for_visible("feature_1_stories")
end

Then /^I should see the order handler$/ do
  selenium.wait_for_visible("order_btn_1")
end

Then /^I should be able to move the second item to the first position$/ do
  selenium.drag_and_drop_to_object("id=order_btn_2","id=order_btn_1")
end

Then /^the items should be reordered$/ do
  selenium.wait_for(:wait_for => :ajax, :javascript_framework => :jquery) do
    assert selenium.is_ordered("id=order_btn_2", "id=order_btn_1")
  end
end

Then /^an error message should be displayed$/ do
  selenium.wait_for_element("css=label.error")
end

Then /^the description field should have an error class$/ do
  selenium.wait_for_text "This field is required."
end

Then /^I should see a "([^\"]*)" link$/ do |model|
  selenium.wait_for_text "#{model}"
end

Then /^the list of feature checkboxes should be viewable$/ do
  selenium.wait_for_visible("fieldset_features")
end
