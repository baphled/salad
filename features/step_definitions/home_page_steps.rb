Given /^there is a last project$/ do
  Project.stub(:last).and_return mock_model(Project,:null_object=>true)
end

Given /^there is no last project$/ do
  Project.stub(:last).and_return nil
end

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

Then /^the latest projects should be displayed$/ do
  response.should have_selector :div, attribute = {:id=>"latest_project"}
end

Then /^there should not be instructions on how to add a project$/ do
  response.should_not have_selector :div, attribute = {:id => 'instructions'}
end
