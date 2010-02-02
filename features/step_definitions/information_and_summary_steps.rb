Then /^the "([^\"]*)" information header should be displayed$/ do |model|
  response.should have_selector :h4, :content => "#{model.capitalize} Info"
end

Then /^the "([^\"]*)" should be displayed$/ do |message|
  response.should have_selector :b, :content => "#{message}:"
end

Then /^a "([^\"]*)"$/ do |message|
  response.should contain message
end

Then /^it should display all the project information$/ do
  Then %{the "project" information header should be displayed}
  ["Title", "Aim","Creation date", "Updated date", "Location"].each do |attribute|
    Then %{the "#{attribute}" should be displayed}
  end
  Then %{a "Total number of Features"}
end

Then /^it should display all the feature information$/ do
  Then %{the "feature" information header should be displayed}
  ["Title", "In order","I want", "As a",].each do |attribute|
    Then %{the "#{attribute}" should be displayed}
  end
  Then %{a "Total number of Stories"}
  Then %{a "Last Story"}
end
