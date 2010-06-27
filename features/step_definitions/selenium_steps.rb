Given /^we edit the feature$/ do
  visit edit_feature_path @feature
end

Given /^we create a feature with a path$/ do
  @feature = Feature.first
end

Given /^a project has tags$/ do
  visit '/projects/1/edit'
  fill_in 'project_tag_list', :with => 'Project management, something else'
  click_button 'Save'
end

Given /^I create a new project$/ do
  visit new_project_path
end

When /^the first (.*) is hovered over$/ do |model|
  selenium.mouse_over("#{model}_1")
end

When /^the (.*) page is loaded$/ do |model|
  selenium.wait_for_element("#{model}_1")
end

When /^I press order$/ do
  selenium.click "css=button.order_icon"
end

When /^I hover over the "([^\"]*)" link$/ do |link|
  selenium.mouse_over("#{link}")
end

When /^I view the changed feature$/ do
  visit feature_path @feature
  selenium.wait_for_element("view-changes")
end

When /^we click on the "([^\"]*)" link$/ do |link|
  click_link link
end

When /^focus on the tag input$/ do
  selenium.click "project_tag_list"
end

When /^I double click "([^\"]*)"$/ do |element|
  selenium.double_click element
end

Then /^the project's information will be display in the sidebar$/ do
  selenium.wait_for_visible("project_1")
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
  selenium.wait_for_visible("story_1")
end

Then /^the feature's information will be display in the sidebar$/ do
  selenium.wait_for_visible("feature_1")
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
  selenium.wait_for_element("css=span.error")
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
  response.should have_selector :a do |content|
    content.should contain "#{link}"
  end
end

Then /^I should see a hover dialog box$/ do
  selenium.wait_for_visible("class=hover ui-widget ui-widget-content ui-corner-all")
end

Then /^I should not see a hover dialog box$/ do
  response.should_not have_selector "css=div.hover"
end

Then /^a tooltip should be visible$/ do
  selenium.wait_for_visible("css=div.tipsy")
end

Then /^it should have a list of all project tags$/ do
  response.should have_selector "a.hover_select"
end

Then /^the tag input should not contain "([^\"]*)"$/ do |tag|
  response.selenium.get_xpath_count("//a[@class='hover_select']").to_i.should be 1
end