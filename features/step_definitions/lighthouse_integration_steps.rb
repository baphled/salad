Given /^we are using the account name "([^\"]*)"$/ do |account_name|
  Lighthouse.account = account_name
end

Given /^we have an the project number "([^\"]*)"$/ do |project_number|
  @project_number = project_number
end

Given /^I visit the parking page$/ do
  visit parking_index_path
end

Given /^we visit the new parking page$/ do
  visit new_parking_path
end

When /^we specify the ticket type "([^\"]*)"$/ do |ticket_parameters|
  @lighthouse_tickets = Lighthouse::Ticket.find(:all, :params => { :project_id => @project_number, :q => "state:open tagged:feature" })
end

When /^we retrieve tickets$/ do
  @lighthouse_tickets.should_not be_empty
end

Then /^each of the features should be using the "([^\"]*)" tag$/ do |tag|
  @lighthouse_tickets.each {|ticket| ticket.tag.should contain 'feature'}
end

Then /^I should be sent to the "([^\"]*)" page$/ do |page_title|
  response.should contain page_title
end