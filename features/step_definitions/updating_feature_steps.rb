Given /^we have a valid feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature")
  @file.should_not be_invalid
end

Given /^there is a valid feature file$/ do
  Given %{we have a valid feature file}
end

Given /^the feature file is saved$/ do
  @feature.save.should be_true
end

Given /^the feature has a valid path$/ do
  @feature.path.should_not be_empty
end

Given /^the feature file is not found$/ do
  @feature = @file.export
  Feature.find_by_title(@feature.title).should be_nil
end

Given /^the feature file has changed$/ do
  @feature.update_attribute(:path, "#{RAILS_ROOT}/tmp/tag_cloud.feature")
end

Given /^the local feature file has changed$/ do
  @feature.update_attribute(:title, 'Something totally different')
end

Given /^the local feature file has changed a featutes scenario$/ do
  @feature.stories.first.update_attribute(:scenario, 'A different story title')
end

Given /^the feature is exported$/ do
  @feature = @file.export
end

When /^the feature has changed "([^\"]*)"$/ do |message|
  @feature.update_attribute(:title, message)
end

When /^we click the features "([^\"]*)"$/ do |link|
  click_link link
end

When /^we click the "([^\"]*)"$/ do |link|
  click_button link
end

Then /^a "([^\"]*)" link should be displayed within the feature$/ do |message|
  response.should have_selector :li, attribute = {:title => message} do |item|
    item.should have_selector :a
  end
end

Then /^we should see the changes to the files$/ do
  response.should have_selector :table, attribute = {:class => 'highlighttable'}
end

Then /^"([^\"]*)" should be highlighted$/ do |message|
  response.should have_selector :span, attribute = {:class => 'gd'} do |highlighted|
    highlighted.should contain message
  end
end

Then /^"([^\"]*)" should be highlighted as added$/ do |message|
  response.should have_selector :span, attribute = {:class => 'gi'} do |highlighted|
    highlighted.should contain message
  end
end

Then /^we should display the patch$/ do
  response.should contain "+Feature: Something different"
end

Then /^the feature should be save$/ do
  Feature.find_by_title(@feature.title).should_not be_nil
end

Then /^we should be redirected back to "([^\"]*)"$/ do |path|
  current_url.should contain path
end

Then /^the source file should be identical to the system file$/ do
  feature = Feature.find @feature.id
  source_feature = FeatureFile.new(@feature.path).export
  feature.export.should === source_feature.export
end
