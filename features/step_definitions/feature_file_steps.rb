Given /^we create a FeatureFile from a none cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/projects.yml")
end

Given /^we create a FeatureFile from a cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/test.feature")
end

When /^a feature is valid$/ do
  @file.should_not be_invalid
end

When /^it has more than one scenario$/ do
  @file.scenarios.count.should >= 1
end

Then /^the object should be valid$/ do
  @file.should_not be_invalid
end

Then /^the feature property should not be nil$/ do
  @file.feature.should_not be_nil
end

Then /^the object should be invalid$/ do
  @file.should be_invalid
end

Then /^the 'In order' property should not be nil$/ do
  @file.in_order.should_not be_nil
end

Then /^the 'As a' property should not be nil$/ do
  @file.as_a.should_not be_nil
end

Then /^the 'I want' property should not be nil$/ do
  @file.i_want.should_not be_nil
end

Then /^the object should have 1 or more scenarios$/ do
  @file.scenarios.should_not be_nil
end

Then /^each scenario should have the expected steps$/ do
  @file.scenarios.first.steps.should_not be_empty
end

Then /^export will return a Feature object$/ do
  @file.export.should be_a Feature
end

Then /^the feature should have stories$/ do
  @file.export.stories.should_not be_empty
end

Then /^these stores should have steps$/ do
  @file.export.stories.each { |story| story.steps.should_not be_nil  }
end
Then /^exported features 'title' will not contain '(.*)' prefix$/ do |content|
  @file.export.title.should_not contain content
end

Then /^exported features 'in_order' will not contain '(.*)' prefix$/ do |content|
  @file.export.in_order.should_not contain content
end

Then /^exported features 'i_want' will not contain '(.*)' prefix$/ do |content|
  @file.export.i_want.should_not contain content
end

Then /^exported features 'as_a' will not contain '(.*)' prefix$/ do |content|
  @file.export.as_a.should_not contain content
end

Then /^each scenario should not be prefixed with 'Scenario;'$/ do
  @file.export.stories.each { |story| story.scenario.should_not contain "Scenario:"}
end