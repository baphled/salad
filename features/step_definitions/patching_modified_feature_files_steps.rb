Given /^there is a feature that is not different from the source file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature") 
  @feature = @file.export
  @feature.save
end

Given /^there is a feature that is different from the source file$/ do
  @feature = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/features/most_used.feature").export
  @feature.save
end

Then /^the flash message "([^\"]*)" should be displayed$/ do |message|
  response.should contain message
end

Then /^we should display a patch with the changes$/ do
  response.should contain 'Patch:'
end

Then /^the patch should be displayed$/ do
  response.body.should_not be_empty
end