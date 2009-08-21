Given /^I can view the (.*) page$/ do |controller|
  visit "/#{controller}"
end