Then /^the new step form should be displayed$/ do
  response.should have_selector :form
end

Then /^fill in the new steps with no errors$/ do
  fill_in 'step_title', :with => 'a new step'
end

Then /^the step should be saved$/ do
  assert !Step.find_by_title("a new step").title.nil?
end

Then /^a flash message 'Step: a new step was created', should be displayed$/ do
  flash.should contain "Step: a new step was created"
end