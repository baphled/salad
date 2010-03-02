Given /^I can view the "(.*)" page$/ do |controller|
  visit "/#{controller}"
end

#@TODO refactor so it more flexible
When /^I click (.*) (.*)$/ do |action,controller|
  visit "/#{controller}/#{action}"
end

When /^I use the "([^\"]*)" link$/ do |link|
  click_link link
end

Then /^the navigation should be displayed$/ do
  response.should have_selector :div, attribute = {:id => 'menu'}
end
