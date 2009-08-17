When /^I choose 'New Step' link$/ do
  click_link 'New Step'
end

When /^I visit the first step$/ do
  visit('/steps/1')
end

Then /^the new step form should be displayed$/ do
  response.should have_selector :form
end

Then /^fill in the new steps with no errors$/ do
  fill_in 'step_title', :with => 'Given we have a new step'
end

Then /^the step should be saved$/ do
  assert !Step.find_by_title("Given we have a new step").title.nil?
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

Then /^the title does not start with 'Given'$/ do
  fill_in 'step_title', :with => 'a new step'
end
