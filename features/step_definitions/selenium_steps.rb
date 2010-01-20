Given /^I visit the stories index page$/ do
  pending # express the regexp above with the code you wish you had
end

When /^the first (.*) is hovered over$/ do |model|
  selenium.mouse_over("#{model}_1")
end

Then /^the project's information will be display in the sidebar$/ do
  selenium.wait_for_visible("project_1_feature")
end

Then /^the story's information will be display in the sidebar$/ do
  selenium.wait_for_visible("story_1_step")
end

Then /^the feature's information will be display in the sidebar$/ do
  selenium.wait_for_visible("feature_1_story")
end
