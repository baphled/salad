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

Given /^the feature is found$/ do
  Feature.find_by_title(@feature.title).should be_true
end

Given /^the feature is not found$/ do
  Feature.find_by_title(@feature.title).should be_nil
end

When /^the feature has changed "([^\"]*)"$/ do |message|
  @feature.update_attribute(:title, message)
end

When /^we click the features "([^\"]*)"$/ do |link|
  click_link link
end

When /^the features diff is viewed$/ do
  visit feature_path(@feature,:format => :patch)
end

When /^the features changes is viewed$/ do
  visit changes_feature_path(@feature)
end

Then /^I should be alerted if a feature file has changed$/ do
  response.should contain "This feature has been changed."
end

Then /^a "([^\"]*)" link should be displayed within the feature$/ do |message|
  response.should contain message
end

Then /^we should see the changes to the files$/ do
  response.should have_selector :table, attribute = {:class => 'highlighttable'}
end

Then /^"([^\"]*)" should be highlighted$/ do |message|
  response.should have_selector :span, attribute = {:class => 'gd'} do |highlighted|
    highlighted.should contain message
  end
end

Then /^we should display the patch$/ do
  response.should contain "+Feature: Something different"
end

Then /^we should be redirected to the feature page$/ do
  response.should contain 'Feature does not have any changes'
end