Given /^we select a feature with no stories$/ do
  @feature = mock_model(Story,:id => 1, :steps => []).as_null_object
end

Given /^we select a feature with stories$/ do
  @steps = []
  3.times { |steps| @steps << mock_model(Step).as_null_object}
  @feature.stub!(:stories).and_return mock_model(Story,:id => 1, :steps => [@steps]).as_null_object
  @feature.stories.should_not == []
end

Given /^the feature has a story with no steps$/ do
  @feature = mock_model(Story,:id => 1, :steps => []).as_null_object
  @feature.stories.first.steps.should == []
end

Given /^the feature has other stories with steps$/ do
  @steps = []
  3.times { |steps| @steps << mock_model(Step).as_null_object}
  @feature = mock_model(Story,:id => 1, :steps => [@steps]).as_null_object
end

When /^the feature with no stories is displayed$/ do
  visit feature_path @feature
end

When /^a user attempts to export a feature$/ do
  click_link 'export feature'
end

When /^we view the first feature$/ do
  visit feature_path @feature
end

When /^the export link should be viewable$/ do
  response.should have_selector :a, attribute = {:href => "/features/1/export"}
end


Then /^the export link should not be viewable$/ do
  response.should_not have_selector :a, attribute = {:href => "/features/2/export"}
end

Then /^the feature should be converted to the necessary cucumber feature format$/ do
  @file = File.open("#{RAILS_ROOT}/spec/fixtures/test.feature")
  response.should contain "Scenario: #{Story.find(1).scenario}"
end

Then /^that story is not added to the exported feature$/ do
  response.should_not contain "Scenario: #{Story.find(2).scenario}"
end

Then /^the feature should be displayed$/ do
  response.should be_success
end
