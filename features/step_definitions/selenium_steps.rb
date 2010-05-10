Given /^we edit the feature$/ do
  visit edit_feature_path @feature
end

Given /^we create a feature with a path$/ do
  @feature = Feature.first
end
               
When /^the first (.*) is hovered over$/ do |model|
  selenium.mouse_over("#{model}_1")
end

When /^the (.*) page is loaded$/ do |model|
  selenium.wait_for_element("#{model}_1")
end

When /^I press order$/ do
  selenium.click "order_icon"
end

When /^I hover over the "([^\"]*)" link$/ do |link|
  selenium.mouse_over("#{link}")
end

When /^I view the changed feature$/ do
  visit feature_path @feature
  selenium.wait_for_element("view-changes")
end

Then /^the project's information will be display in the sidebar$/ do
  selenium.wait_for_visible("project_1_features")
end

Given /^we click the edit link$/ do
  click_link 'Edit'
end

Given /^we change the feature's title to "([^\"]*)"$/ do |content|
  selenium.wait_for_visible("id=feature_title")
  fill_in 'feature_title', :with => content
  click_button 'Save'
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

Then /^a JS based error message should be displayed$/ do
  selenium.wait_for_element("css=label.error")
end

Then /^the form should have an client side error$/ do
  selenium.wait_for_text "This field is required."
end

Then /^the client side error message should be "([^\"]*)"$/ do |message|
  selenium.wait_for_text "#{message}"
end

Then /^there should be an AJAX request$/ do
  selenium.wait_for(:wait_for => :ajax, :javascript_framework => :jquery)
end

Then /^the form should be hidden$/ do
  response.should contain "view form"
end

Then /^a flash message "([^\"]*)" should be dynamically displayed$/ do |message|
  response.should contain "#{message}"
end

Then /^there should be a "([^\"]*)" link$/ do |link|
  response.should contain "#{link}"
end

Then /^a tooltip should be visible$/ do
  selenium.wait_for_visible("css=div.tooltip")
end