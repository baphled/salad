When /^I view the "([^\"]*)" form$/ do |model|
  visit "/#{model}/new"
end

When /^fill in the project form$/ do
  When %{we fill in the project title with 'A project'}
  When %{we fill in the project aim with 'An aim'}
  When %{we fill in the project description with 'A description'}
end

When /^fill in the feature form$/ do
  When %{we fill in the feature title with 'Logging in'}
  When %{we fill in the feature in_order with 'to create the best app'}
  When %{we fill in the feature as_a with 'user'}
  When %{we fill in the feature i_want with 'the best project ever'}
end

When /^fill in the story form$/ do
  When %{we fill in the story scenario with 'this is our stories scenario'}
end

When /^fill in the step form$/ do
  When %{we fill in the step title with 'Given we have a new step'}
end