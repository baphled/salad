Given /^I have the first "([^\"]*)"$/ do |model|
  @model = model.capitalize.constantize.first
end

When /^I use the "([^\"]*)" link$/ do |link|
  click_link link
end

When /^we click import "([^\"]*)"$/ do |feature_title|
  click_button "Import #{feature_title}"
end

Then /^the navigation should be displayed$/ do
  response.should have_selector :div, attribute = {:id => 'menu'}
end

Then /^the "([^\"]*)" will be selected$/ do |menu_item|
  response.should have_selector :li, attribute = {:class => 'selected', :id => menu_item}
end

Then /^a "([^\"]*)" button should be displayed$/ do |name|
  response.should have_selector :button do |content|
    content.should contain name
  end
end