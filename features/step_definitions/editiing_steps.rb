When /^we fill in the project (.*) with '(.*)'$/ do |attr, value|
  fill_in "project_#{attr}", :with => "#{value}"
end
