Then /^a flash message '(.*)' should be displayed$/ do |message|
  flash[:notice].should contain "#{message}"
end

Then /^I should not be redirected to the form$/ do
  response.should_not have_selector :form
end

When /^we click the "([^\"]*)" feature$/ do |link|
  click_link "#{link}"
end

When /^we submit the new feature$/ do
  click_button 'save'
end

# @TODO Refactor to work with other form actions
When /^"([^\"]*)" the "([^\"]*)" form$/ do |form_action, item|
  case form_action
    when /update/
      # Do nothing
    when /fill in/
      When %{I fill in the #{item} form"}
    else
      raise "Can't find form action\"#{form_action}\".\n" +
        "Now, go and add a mapping in #{__FILE__}"
  end
end
