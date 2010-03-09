Given /^we have a valid feature file$/ do
  Given %{we create a FeatureFile from a cucumber feature file with a scenario outline}
  @feature = @file.export
end

When /^the feature has changed$/ do
  @feature.update_attribute(:title, 'something totally different').should be_true
end

Then /^I should be alerted if a feature file has changed$/ do
  pending "Need to rollout implement via specs"
  flash[:notice].should contain "#{@feature.title} is different from the source file"
end
