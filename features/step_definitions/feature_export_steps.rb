Given /^we select a feature with no stories$/ do
  Feature.find(2).stories.should == []
end

Given /^we select a feature with stories$/ do
  Feature.find(1).stories.should_not == []
end

#need a better way to test this
Given /^the feature has a story with no steps$/ do
  Feature.find(1).stories.first.steps.should == []
end

Given /^the feature has other stories with steps$/ do
  Feature.find(1).stories.find(1).steps
end

When /^the feature with no stories is displayed$/ do
  visit('/features/2')
end

When /^a user attempts to export a feature$/ do
  click_link 'export feature'
end

When /^we view the first feature$/ do
  visit('/features/1')
end

Then /^the export link should be viewable$/ do
  visit('/features/1')
  response.should have_selector :a, attribute = {:href => "/features/1/export"}
end


Then /^the export link should not be viewable$/ do
  response.should_not have_selector :a, attribute = {:href => "/features/2/export"}
end

Then /^the feature should be converted to the necessary cucumber feature format$/ do
  @file = File.open("#{RAILS_ROOT}/spec/fixtures/test.feature")
  response.should contain "#{@file.read}"
end

Then /^that story is not added to the exported feature$/ do
  response.should_not contain "Scenario: #{Story.find(2).title}"
end

