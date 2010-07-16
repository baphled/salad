Given /^the ([^\"]*) has no "([^\"]*)"$/ do |model ,association|
  case model
  when /project/
    Project.stub!(association.to_sym).and_return []
    Project.send(association).stub!(:count).and_return 0
  when /feature/
    Feature.stub!(association.to_sym).and_return []
    Feature.send(association).stub!(:count).and_return 0
  when /story/
    Story.stub!(association.to_sym).and_return []
    Story.send(association).stub!(:count).and_return 0
  when /step/
    Step.stub!(association.to_sym).and_return []
    Step.send(association).stub!(:count).and_return 0
  else
    raise "Can't find mapping from \"#{model}\".\n" +
        "Now, go and add a mapping in #{__FILE__}"
  end
end

Given /^there is a project with no features$/ do
  @project = mock_model(Project, :features => []).as_null_object
  Project.stub!(:find).and_return @project
end

Given /^there is a feature with no stories$/ do
  @feature = mock_model(Feature, :stories => []).as_null_object
  Feature.stub!(:find).and_return @feature
end

Given /^there is a story with no steps$/ do
  @story = mock_model(Story, :steps => []).as_null_object
  Story.stub!(:find).and_return @story
end

Then /^the "([^\"]*)" information header should be displayed$/ do |model|
  response.should have_selector :h4 do |content|
    content.should contain "#{model.capitalize} Info"
  end
end

Then /^the "([^\"]*)" should be displayed$/ do |message|
  response.should have_selector :b do |content|
    content.should contain "#{message}:"
  end
end

Then /^a "([^\"]*)"$/ do |message|
  response.should contain message
end

Then /^it should display all the project information$/ do
  Then %{the "project" information header should be displayed}
  ["Title", "Aim","Creation date", "Updated date"].each do |attribute|
    Then %{the "#{attribute}" should be displayed}
  end
  if not @project.features != 0
    Then %{a "Total number of Features"}
  end
end

Then /^it should display all the feature information$/ do
  Then %{the "feature" information header should be displayed}
  ["Title", "In order","I want", "As a"].each do |attribute|
    Then %{the "#{attribute}" should be displayed}
  end
  if not @feature.stories != 0
    Then %{a "Total number of Stories"}
    Then %{a "Last Story"}
  end
end

Then /^it should display all the story information$/ do
  Then %{the "story" information header should be displayed}
  Then %{the "Scenario" should be displayed}
  if not @story.steps.count != 0
    Then %{a "Total number of Steps"}
    Then %{a "Last Step"}    
  end
end

Then /^it should display all the step information$/ do
  Then %{the "step" information header should be displayed}
end

Then /^the copy "([^\"]*)" should be displayed$/ do |copy|
  response.should contain copy
end

Then /^"([^\"]*)" should not be displayed$/ do |copy|
  response.should_not contain copy
end