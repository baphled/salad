Given /^there is a feature that is not different from the source file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature") 
  @feature = @file.export
  @feature.save
end

Given /^there is a feature that is different from the source file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature") 
  @feature = @file.export
  File.open("#{RAILS_ROOT}/tmp/tag_cloud.feature", 'w') { |f| f.write(@feature.export) }
  @feature.update_attribute(:path,"#{RAILS_ROOT}/tmp/tag_cloud.feature")
end

When /^we view the feature with the "([^\"]*)" format$/ do |format|
  visit feature_path(@feature, :format => format)
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