Given /^we select a feature with no stories$/ do
  @feature = mock_model(Feature, :stories => []).as_null_object
  Feature.stub!(:find).and_return @feature
end

Given /^we select a feature with stories$/ do
  @steps = []
  3.times { |steps| @steps << Step.make }
  @feature.stories << Story.make(:steps => [@steps])
  Feature.stub!(:find).and_return @feature
end

Given /^the feature has a story with no steps$/ do
  @has_no_steps = Story.make
  @feature.stories << @has_no_steps
end

Given /^the feature has other stories with steps$/ do
  @steps = []
  3.times { |steps| @steps << mock_model(Step).as_null_object}
  @feature.stub!(:stories).and_return mock_model(Story,:id => 1, :steps => [@steps]).as_null_object
end

When /^a user attempts to export a feature$/ do
  click_link 'Export a feature'
end

When /^the export link should be viewable$/ do
  response.should have_selector :a, attribute = {:href => "#{export_feature_path(@feature)}"}
end


Then /^the export link should not be viewable$/ do
  response.should_not have_selector :a, attribute = {:href => "#{export_feature_path @feature}"}
end

Then /^the feature should be converted to the necessary cucumber feature format$/ do
  @file = File.open("#{RAILS_ROOT}/spec/fixtures/test.feature")
  response.should contain "Scenario: #{@feature.stories.first.scenario}"
end

Then /^that story is not added to the exported feature$/ do
  response.should_not contain "Scenario: #{@has_no_steps.scenario}"
end