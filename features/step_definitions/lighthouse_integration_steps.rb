Given /^we are using the account name "([^\"]*)"$/ do |account_name|
  Lighthouse.account = account_name
end

Given /^we have an the project number "([^\"]*)"$/ do |project_number|
  @project = Lighthouse::Project.find(project_number)
end

When /^we retrieve tickets$/ do
  @project.tickets.should_not be_empty
end