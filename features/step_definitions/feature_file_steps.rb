Given /^we create a FeatureFile from a none cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/projects.yml")
end

Given /^we create a FeatureFile from a cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/test.feature")
end

Given /^we have a feature file$/ do
  File.exists?("#{RAILS_ROOT}/spec/fixtures/test.feature").should be_true
end

Given /^we create a FeatureFile from a cucumber feature file with a scenario outline$/ do
  @file = FeatureFile.new "#{RAILS_ROOT}/features/plain/most_used.feature"
end

Given /^the feature file is not present in the system$/ do
  Feature.find_by_title(@feature.title).should be_nil
end

When /^a feature is valid$/ do
  @file.should_not be_invalid
end

When /^it has more than one scenario$/ do
  @file.scenarios.count.should >= 1
end

When /^we parse a file$/ do
  @file = @cf.parse Cucumber::StepMother.new, {}
end

When /^it has a scenario outline$/ do
  @file.read.should contain "Scenario Outline:"
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

Then /^each scenario should not be prefixed with 'Scenario:'$/ do
  @file.export.stories.each { |story| story.scenario.should_not contain /^Scenario:/}
end

When /^each scenario should not be prefixed with 'Scenario Outline:'$/ do
  @file.export.stories.each { |story| story.scenario.should_not contain /^Scenario Outline:/}
end

Then /^our parse FeatureFile should be called$/ do
  @file.should_receive :parse
end

Then /^a scenario outline should be found$/ do
  @file.to_sexp[3][0].should == :scenario_outline
end

Then /^each scenario outline should have the expected steps$/ do
  @file.export.stories.first.steps.should_not be_empty
end

Then /^the scenario outline should precede its examples$/ do
  @file.export.stories.first.examples.should_not be_empty
end

Then /^the example should have a list of actions$/ do
  @file.export.stories.first.examples.first.actions.should_not be_empty
end

Then /^the actions should only contain "([^\"]*)"$/ do |words|
  words.split(',').each_with_index { |word,index|  @file.export.stories.first.examples.first.actions[index].title.should == word }
end

Then /^the "([^\"]*)" should have "([^\"]*)" associated to it "([^\"]*)" of times$/ do |action, current_item, amount|
  @file.export.stories.first.examples.first.actions.each {|current_action| count = 0; current_action.items.each {|item| (item.title == current_item)? count += 1 :nil;  } ; count.to_s.should eql amount if current_action.title == action }
end

Then /^we want to be able to import the feature$/ do
  response.should have_selector :a, :content => "Import tag cloud"
end