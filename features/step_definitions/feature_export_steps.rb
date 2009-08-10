Given /^we select a feature with no stories$/ do
  Feature.find(2).stories.should == []
end

When /^the feature with no stories is displayed$/ do
  visit('/features/2')
end

Then /^the the export link should not be viewable$/ do
  response.should_not have_selector :a, attribute = {:href => "/features/2/export"}
end
