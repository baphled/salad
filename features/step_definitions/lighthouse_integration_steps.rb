Given /^we are using the account name "([^\"]*)"$/ do |account_name|
  Lighthouse.account = account_name
end

Given /^we have an the project number "([^\"]*)"$/ do |project_number|
  @project_number = project_number
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

Then /^each feature should be listed on the parking$/ do
  @lighthouse_tickets.each {|ticket| response.should contain ticket.title }
end