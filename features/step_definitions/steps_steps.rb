Given /^the step "([^\"]*)" is created$/ do |step|
  Step.make(:title => step)
end

Then /^the new step form should be displayed$/ do
  response.should have_selector :form
end

Then /^the step should be saved as '(.*)'$/ do |message|
  assert !Step.find_by_title("#{message}").title.nil?
end
  
Then /^a flash message '(.*)', should be displayed$/ do |flash|
  flash.should contain "#{flash}"
end

Then /^the step should be not saved$/ do
  response.should have_selector :form
end

Then /^I check 'my first story'$/ do
  check "#{Story.first.scenario}"
end

Then /^I should see check boxes for all steps it can be linked to$/ do
  response.should have_selector :input, attribute = {:type=>"checkbox",:value=> "#{Story.first.id}", :id=>"step_story_id_#{Story.first.id}"}
end

Then /^the message '(.*)' should be displayed$/ do |message|
  response.should contain "#{message}"
end

Given /^there is a story with the "([^\"]*)" "([^\"]*)"$/ do |param, value|
  @story = Story.make( param.to_sym => value )
end