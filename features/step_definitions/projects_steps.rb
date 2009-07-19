Given /^I can view the site$/ do
  visit "/projects"
end

When /^I click new project$/ do
  visit "/projects/new"
end