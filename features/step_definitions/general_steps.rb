Then /^a flash message '(.*)' should be displayed$/ do |message|
  flash.should contain "#{message}"
end

Then /^I should not be redirected to the form$/ do
  response.should_not have_selector :form
end