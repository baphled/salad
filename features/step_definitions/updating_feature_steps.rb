Given /^we have a valid feature file$/ do
  Given %{we create a FeatureFile from a cucumber feature file with a scenario outline}
  @feature = @file.export
end

Given /^the feature file is saved$/ do
  @feature.save.should be_true
end

When /^the feature has changed$/ do
  feature.stub!(:is_diff?).and_return true
  @feature.is_diff?.should be_true
end

Then /^I should be alerted if a feature file has changed$/ do
#  pending "Need to rollout implement via specs"
  response.should contain "This feature has been changed."
end
