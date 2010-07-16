When /^I view the "([^\"]*)" form$/ do |model|
  visit "/#{model}/new"
end

When /^I fill in the ([^\"]*) form$/ do |model|
  fill_form model
end

When /^I don't fill in the ([^\"]*) "([^\"]*)"$/ do |model, opt|
  fill_form model.singularize, opt => ''
end

When /^I update the ([^\"]*) form$/ do  |model|
end

# @TODO Refactor all scenarios that use this step to make use of the web_steps instead
When /^we fill in the (.*) (.*) with '(.*)'$/ do |controller, attr, value|
  fill_in "#{controller}_#{attr}", :with => "#{value}"
end

When /^I fill in the ([^\"]*) form ([^\"]*) with "([^\"]*)"$/ do |model, property, value|
  fill_form model.singularize, property => "#{value}"
end

When /^I fill in the ([^\"]*) form with duplicate data$/ do |model|
  fill_in_form_with_duplicate_data model
end

# @TODO Refactor to work with other form actions
When /^"([^\"]*)" the "([^\"]*)" form$/ do |form_action, item|
  case form_action
    when /update/
      # Do nothing
    when /fill in/
      When %{I fill in the #{item} form"}
    else
      raise "Can't find form action\"#{form_action}\".\n" +
        "Now, go and add a mapping in #{__FILE__}"
  end
end

Then /^I should not be redirected to the form$/ do
  response.should_not have_selector :form
end

Then /^the ([^\"]*) information should not be saved$/ do |model|
  response.should have_selector :form
end