Given /^we create a feature with a path$/ do
  @feature = Feature.make(:path => "#{RAILS_ROOT}/spec/fixtures/features/tag_cloud.feature")
end

Given /^a project has tags$/ do
  visit edit_project_path @project
  fill_in 'project_location', :with => ''
  fill_in 'project_tag_list', :with => 'Project management, something else'
  click_button 'Save'
end

Given /^the project has one feature$/ do
  feature = Feature.first
  @project = mock_model(Project, :id => 1, :features => [Feature.first]).as_null_object
  @project.stub!(:features).and_return feature
end

When /^the first (.*) is hovered over$/ do |model|
  selenium.mouse_over("css=ul##{model.pluralize} >li div.#{model}")
end

When /^the (.*) page is loaded$/ do |model|
  selenium.wait_for_element("#{model}_1")
end

When /^I press order$/ do
  selenium.click "css=button.order_icon"
end

When /^I hover over the "([^\"]*)" (?:link|button)$/ do |link|
  selenium.mouse_over("#{link}")
end

When /^focus on the tag input$/ do
  selenium.click "project_tag_list"
end

When /^I submit the form$/ do
  selenium.click "css=button.button"
end

When /^I use the features path link$/ do
  click_link "#{@feature.path}"
end

When /^I click page "([^\"]*)"$/ do |page_number|
  selenium.click page_number
end

Then /^the project's information will be display in the sidebar$/ do
  selenium.wait_for_visible("project_1")
end

Then /^the story's information will be display in the sidebar$/ do
  selenium.wait_for_visible("story_1")
end

Then /^the feature's information will be display in the sidebar$/ do
  selenium.wait_for_visible("css=div#sidebar > ul#feature_stories")
end

Then /^the step's information will be display in the sidebar$/ do
  selenium.wait_for_visible("step_1")
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


Then /^the system merge page should be displayed$/ do
  selenium.wait_for_visible("css=div#legend")
end
Then /^there should be a "([^\"]*)" link$/ do |link|
  response.should have_selector :a do |content|
    content.should contain "#{link}"
  end
end

Then /^I should see a hover dialog box$/ do
  selenium.wait_for_visible("css=div.hover", :timeout_in_seconds => 10)
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

Then /^the sidebar will be rendered via AJAX$/ do
  selenium.wait_for_visible("css=div#sidebar")
end

Then /^the side bar should not be rendered$/ do
  response.should_not have_selector "css=div#sidebar"
end

When /^I click "([^\"]*)"$/ do |selector|
  selenium.wait_for_element("css=#{selector}", :timeout_in_seconds => 10)
  selenium.click "css=#{selector}"
end

Then /^the import link should be visible$/ do
  selenium.wait_for_visible("css=span#panel ul.icons > li a#import")
end

Then /^the panel icons should be visible$/ do
  selenium.wait_for_visible("css=span#panel ul.icons")
end

Then /^I should see the imports page$/ do
  selenium.wait_for_element("css=div#myTabs", :timeout_in_seconds => 180)
end

When /^I import "([^\"]*)"$/ do |selector|
  selenium.wait_for_element("css=#{selector}", :timeout_in_seconds => 10)
  selenium.click "css=#{selector}"
end

Then /^the imports will be rendered via AJAX$/ do
  selenium.wait_for_visible("css=div#myTabs", :timeout_in_seconds => 2 * 60)
end

When /^focus is off the tag input$/ do
  selenium.mouse_over("css=div#header")
end

Then /^it should "([^\"]*)" have an order button$/ do |have_or_have_not|
  if have_or_have_not == 'does not'
    response.should_not have_selector "css=button#button"
  else
    selenium.wait_for_element "css=button#button",  :timeout_in_seconds => 10
  end
end

Then /^select the "([^\"]*)" tab$/ do |tab|
  click_link tab
end

Then /^the "([^\"]*)" button should be visible$/ do |tab_name|
  response.should contain tab_name
end

Then /^the "([^\"]*)" tab should not be visible$/ do |tab_name|
  selenium.wait_for_no_element "webrat=#{tab_name}"
end

Then /^a flash message should be displayed via AJAX$/ do
  selenium.wait_for_element("css=div.flash", :timeout_in_seconds => 10)
end

Then /^a dialog box should appear$/ do
  selenium.wait_for_visible("css=div.dialog", :timeout_in_seconds => 10)
end

Then /^the submit button should be disabled$/ do
  selenium.wait_for_element("css=button.ui-button-disabled", :timeout_in_seconds => 10)
end

Then /^the pagination panel should be displayed$/ do
  selenium.wait_for_element("css=div.pagination")
end

Then /^the JS message "([^\"]*)" should be displayed$/ do |message|
  selenium.wait_for_element("css=div.loading") do
    response.should contain message
  end
end

Then /^the icons panel should be visible$/ do
  selenium.wait_for_element("css=span#panel", :timeout_in_seconds => 10)
end

Then /^pagination should be visible$/ do
  selenium.wait_for_element("css=div.pagination", :timeout_in_seconds => 10)
end

Then /^the item's panel should be visible$/ do
  selenium.wait_for_visible("css=span.view-panel", :timeout_in_seconds => 10)
end