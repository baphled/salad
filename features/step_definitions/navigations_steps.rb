Given /^I can view the (.*) page$/ do |controller|
  visit "/#{controller}"
end

When /^I click (.*) (.*)$/ do |action,controller|
  visit "/#{controller}/#{action}"
end