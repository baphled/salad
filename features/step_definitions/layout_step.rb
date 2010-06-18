When /^I view the "([^\"]*)" "([^\"]*)"$/ do |model, action|
  visit "/#{model}/#{action}"
end

Then /^the view should not have a sidebar$/ do
  response.should_not have_selector :div, attribute = {:id => 'sidebar'}
end