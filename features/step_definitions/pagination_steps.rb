Given /^there are "([^\"]*)"$/ do |model|
  build_model_by_amount 3, model
  model.capitalize.singularize.constantize.all.should_not be_empty
end

Given /^there are less than 5 "([^\"]*)"$/ do |model|
  assert model.capitalize.singularize.constantize.all.count <= 5
end

Given /^the ([a-z]*) has more than ([0-9]*) ([a-z]*)$/ do |model, amount, association|
  associations = []
  number = amount.to_i + 1
  current_model = eval("@#{model}")
  number.times { current_model.send(association.pluralize.to_sym) << association.singularize.capitalize.constantize.make }
end

Then /^we should not see our pagination$/ do
  response.should_not have_selector :div, attribute = {:class => "pagination"}
end