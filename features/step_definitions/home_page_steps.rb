Given /^there is a last project$/ do
  @project = mock_model(Project,
                            :title => 'A project',
                            :creation_date => Time.now.to_s(:long),
                            :features => [mock_model(Feature).as_new_record],
                            :null_object => true).as_new_record
  Project.stub(:last).and_return @project
end

Given /^there is no last project$/ do
  Project.stub(:last).and_return nil
end

Given /^the project has no features$/ do
  @project.features.stub(:count).and_return 0
end

Then /^I should see that no projects are on the system$/ do
  response.should contain 'There are no projects'
end

Then /^I should be instructed on how to add a project$/ do
  response.should have_selector :div do |instructions|
    instructions.should contain "add a project"
  end
end

Then /^it should be displayed$/ do
  response.should have_selector :div, attribute = {:id=>"latest_project"}
end

Then /^there should not be instructions on how to add a project$/ do
  response.should_not contain "add a project"
end

Then /^it should display its title$/ do
  response.should contain @project.title
end

Then /^it should display when the project was created$/ do
  response.should contain @project.creation_date
end

Then /^how many features the project has$/ do
  response.should contain "#{@project.features.count} feature"
end

Then /^it should display a message about the project not having any features$/ do
  response.should contain "has no features"
end

Then /^it should display the word features$/ do
  response.should contain "#{@project.features.count} features"
end
