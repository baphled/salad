Given /^we create a FeatureFile from a none cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/fixtures/project.yml")
end

Given /^we create a FeatureFile from a cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/fixtures/test.feature")
end

Then /^the object should be valid$/ do
  @file.should_not be_invalid
end

Then /^the feature property should not be null$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the object should be invalid$/ do
  @file.should be_invalid
end
