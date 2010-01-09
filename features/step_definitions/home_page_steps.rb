When /^we view the home page$/ do
  visit('/')
end

Then /^I should see that no projects are on the system$/ do
  response.should contain 'There are no projects'
end

Then /^I should be instructed on how to add a project$/ do
  response.should have_selector :div do |instructions|
    instructions.should contain "Add a project"
  end
end