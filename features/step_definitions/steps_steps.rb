Then /^the new step form should be displayed$/ do
  response.should have_selector :form
end
