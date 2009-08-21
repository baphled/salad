When /^we fill in the project (.*) with '(.*)'$/ do |attr, value|
  fill_in "project_#{attr}", :with => "#{value}"
end

When /^we fill in the step (.*) with '(.*)'$/ do |attr, value|
  fill_in "step_#{attr}", :with => "#{value}"
end