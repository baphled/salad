When /^I choose 'New Step' link$/ do
  click_link 'New Step'
end

When /^I visit the first step$/ do
  visit('/steps/1')
end

Then /^the new step form should be displayed$/ do
  response.should have_selector :form
end

Then /^the step should be saved as '(.*)'$/ do |message|
  assert !Step.find_by_title("#{message}").title.nil?
end
  
Then /^a flash message 'Step: Given we have a new step was created', should be displayed$/ do
  flash.should contain "Step: Given we have a new step, was created"
end

Then /^the step should be not saved$/ do
  response.should have_selector :form
end

Then /^I don't fill in the steps title$/ do
  
end

Then /^I check 'my first story'$/ do
  check 'step_story_id_1'
end

Then /^I should see check boxes for all steps it can be linked to$/ do
  response.should have_selector :input, atrribute = {:type=>"checkbox",:value=>"1",:id=>"step_story_id_1"}
end

Then /^the title does not start with '(.*)'$/ do |prefix|
  fill_in 'step_title', :with => 'a new step'
end

Then /^the title does start with '(.*)'$/ do |prefix|
  fill_in 'step_title', :with => "#{prefix} we have a new step"
end

Then /^the message '(.*)' should be displayed$/ do |message|
  response.should have_selector :li, :content => "#{message}"
end
