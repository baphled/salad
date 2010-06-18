When /^I view the "([^\"]*)" form$/ do |model|
  visit "/#{model}/new"
end
