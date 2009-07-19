Given /^I can view the site$/ do
  visit "/projects"
end

When /^I click new project$/ do
  visit "/projects/new"
end

When /^fill in the new project with no errors$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_description', :with => 'This is a description'
  fill_in 'project_aim', :with => 'the aim of our project is...'
end

When /^don't fill in the title$/ do
  fill_in 'project_description', :with => 'This is a description'
  fill_in 'project_aim', :with => 'the aim of our project is...'
end

When /^don't fill in the description$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_aim', :with => 'the aim of our project is...'
end

When /^don't fill in the aim$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_description', :with => 'This is a description'
end

Then /^submit the form$/ do
  click_button 'Submit'
end

Then /^the project information should be saved$/ do
  assert_response :success
end

Then /^I should be redirected to the new project$/ do
  current_url.should_not eql "/projects/new"
end

Then /^a flash message notice should be displayed$/ do
  flash.should contain "A project was created"
end

Then /^I should be redirected to the new project form$/ do
  response.should have_selector :form
end

Then /^a form error must be displayed$/ do
  response.should have_selector :div, attribute = {:class => "errorExplanation"}
end

Then /^the user should be told the must have a (.*)$/ do |value|
  response.should contain "#{value.capitalize} can't be blank"
end
