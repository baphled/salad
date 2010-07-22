Given /^the "([^\"]*)" has ([^\"]*) "([^\"]*)"$/ do |model, amount, assoc|
  build_associations model, assoc, amount
end

Then /^a flash message '(.*)' should be displayed$/ do |message|
  flash[:notice].should contain "#{message}"
end

When /^we click the "([^\"]*)" feature$/ do |link|
  click_link "#{link}"
end

When /^we submit the new feature$/ do
  click_button 'save'
end


