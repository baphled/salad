Given /^I can view the (.*) page$/ do |controller|
  visit "/#{controller}"
end

#@TODO refactor so it more flexible
When /^I click (.*) (.*)$/ do |action,controller|
  visit "/#{controller}/#{action}"
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