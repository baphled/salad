Given /^we have a valid feature file$/ do
  @file = FeatureFile.new "#{RAILS_ROOT}/features/plain/tag_cloud.feature"
  @feature = @file.export
end

Given /^the feature file is saved$/ do
  @feature.save.should be_true
end

Given /^the feature has a path$/ do
  @feature.update_attribute(:path, "#{RAILS_ROOT}/features/plain/tag_cloud.feature")
end

When /^the feature has changed$/ do
  @feature.update_attribute(:title, 'Something different')
end

Then /^I should be alerted if a feature file has changed$/ do
  response.should contain "This feature has been changed."
end

Then /^a "([^\"]*)" link should be displayed within the feature$/ do |message|
  response.should contain message
end