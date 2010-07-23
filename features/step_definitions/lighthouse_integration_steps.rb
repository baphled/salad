Given /^I are using the account name "([^\"]*)"$/ do |account_name|
  Lighthouse.account = account_name
end

Given /^I have an the project number "([^\"]*)"$/ do |project_number|
  @project_number = project_number
end

Given /^there are resources$/ do
  @resources = Resource.all
end

Given /^I have set up the lighthouse resource$/ do
  When %{I am on "new parking"}
  And %{I fill in the resource form}
  Then %{submit the form}
end

Given /^there are parked tickets on the system$/ do
  LightHouse.stub!(:all).and_return [mock_model(Lighthouse).as_null_object]
end

Given /^I have a tickets that is invalid$/ do
  LightHouse.stub!(:create).and_return false
end

Given /^there are no tickets parked$/ do
  LightHouse.stub!(:all).and_return []
end

Given /^there are tickets$/ do
  @lighthouse_tickets = Lighthouse::Ticket.find(:all, :params => { :project_id => @project_number, :q => "state:open tagged:feature" })
  LightHouse.stub!(:all).and_return @lighthouse_tickets
end


Given /^there are no resources$/ do
  Resource.stub!(:all).and_return []
end

When /^I specify the ticket type "([^\"]*)"$/ do |ticket_parameters|
  @lighthouse_tickets = Lighthouse::Ticket.find(:all, :params => { :project_id => @project_number, :q => "state:open tagged:#{ticket_parameters}" })
end

When /^I retrieve tickets$/ do
  @lighthouse_tickets.should_not be_empty
end

Then /^I should be sent to the "([^\"]*)" page$/ do |page_title|
  response.should contain page_title
end

Then /^the resource information should be saved$/ do
  Resource.find_by_name("baphled").should_not be_nil
end

Then /^there should be a list of tickets found$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li
  end
end

Then /^I should be able to select tickets to add to parking$/ do
  response.should have_selector :div do |content|
    content.should have_selector :input, attribute = {:type => "checkbox"}
  end
end

Then /^one item should be saved as parked items$/ do
  LightHouse.first.ticket_id.should_not eql 9
end

Then /^a list of parked ticket should be displayed$/ do
  response.should have_selector :ul, attribute  = {:id => "resource_list"} do |list|
    list.should have_selector :li
  end
end

Then /^I should not see a list of tickets to import$/ do
  response.should_not have_selector :ul, attribute = {:id => "resource_list"}
end

Then /^the save tickets should have a body$/ do
  LightHouse.first.body.should_not be_empty
end

Then /^the ticket search form should not be visible\.$/ do
  response.should_not have_selector :form, attribute = {:action => tickets_parking_path}
end

Then /^the saved tickets should have a title$/ do
  LightHouse.first.title.should_not be_empty
end

When /^I click on the first ticket$/ do
  click_link @lighthouse_tickets.first.title
end

Then /^the feature form should be displayed$/ do
  response.should have_selector :form
end

Then /^there a error "([^\"]*)" should be displayed$/ do |message|
  response.should have_selector :ul do |error|
    error.should contain message
  end
end
