Given /^there are "([^\"]*)" tags$/ do |model|
  @temp = model.capitalize.constantize.first
  @temp.update_attribute :tag_list, ["Tag 1","Tag 2","Tag 3"]
end
Given /^the "([^\"]*)" tags are not empty$/ do |model|
  @temp.tag_counts.should_not be_empty
end

Then /^the tags cloud should be displayed$/ do
  response.should have_selector :div, attribute = {:id => "cloud_tag" }
end
