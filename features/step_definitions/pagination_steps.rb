Given /^there are "([^\"]*)"$/ do |model|
  build_model_by_amount 3, model
  model.capitalize.singularize.constantize.all.should_not be_empty
end

Given /^there are less than 5 "([^\"]*)"$/ do |model|
  assert model.capitalize.singularize.constantize.all.count <= 5
end

Given /^the ([a-z]*) has more than ([0-9]*) ([a-z]*)$/ do |model, amount, association|
  build_model_associations_more_than amount, model, association
end

Then /^we should not see our pagination$/ do
  response.should_not have_selector :div, attribute = {:class => "pagination"}
end