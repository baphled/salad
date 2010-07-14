Given /^there is a "([^\"]*)"$/ do |model|
  # pending 'This step seems to cause all subsequent steps to break which use find on a model, need to find out why'
  @model = mock_model(model.capitalize.constantize).as_null_object
  model.capitalize.constantize.stub!(:find).and_return @model
end

Given /^the item has no "([^\"]*)"$/ do |association|
  # pending 'This step seems to cause all subsequent steps to break which use find on a model, need to find out why'
  @model.stub!(association.to_sym).and_return []
  @model.send(association).stub!(:count).and_return 0
end

When /^the "([^\"]*)" is viewed$/ do |model|
  visit "#{model.pluralize}/#{@model.id}/"
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