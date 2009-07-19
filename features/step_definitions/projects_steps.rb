Given /^I can view the site$/ do
  visit "/projects"
end

When /^I click new project$/ do
  visit "/projects/new"
end

When /^fill in the new project$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_description', :with => 'This is a description'
  fill_in 'project_aim', :with => 'the aim of our project is...'
  click_button 'Submit'
end
