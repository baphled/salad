Given /^there are "([^\"]*)"$/ do |model|
  model.capitalize.singularize.constantize.all.should_not be_empty
end

Given /^there are less than 5 "([^\"]*)"$/ do |model|
  assert model.capitalize.singularize.constantize.all.count <= 5
end

When /^I visit the "([^\"]*)"$/ do |model|
  visit model
end

Then /^we should not see our pagination$/ do
  response.should_not have_selector :div, attribute = {:class => "pagination"}
end