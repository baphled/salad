When /^I view the "([^\"]*)" "([^\"]*)"$/ do |model, action|
  visit "/#{model}/#{action}"
end

Then /^the view should not have a sidebar$/ do
  response.should_not have_selector :div, attribute = {:id => 'sidebar'}
end

Then /^the view "([^\"]*)" have a sidebar$/ do |matcher|
  if matcher == 'should'
    response.should have_selector :div, attribute = {:id => 'sidebar'}
  else matcher == 'should not'
    response.should_not have_selector :div, attribute = {:id => 'sidebar'}
  end
end
