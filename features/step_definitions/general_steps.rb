Given /^there is a ([^\"]*)$/ do |model|
  eval("@#{model} = model.camelcase.constantize.make")
end

Given /^the "([^\"]*)" has (\d+) "([^\"]*)"$/ do |model, amount, assoc|
  build_associations_by_amount amount, model, assoc
end

Given /^the ([^\"]*) has (\d+) ([^\"]*)s$/ do |model, amount, assoc|
  Given %{the "#{model}" has #{amount} "#{assoc}"}
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


