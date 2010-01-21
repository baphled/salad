When /^the first (.*) is hovered over$/ do |model|
  selenium.mouse_over("#{model}_1")
end

When /^the (.*) page is loaded$/ do |model|
  selenium.wait_for_element("#{model}_1")
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

Then /^each feature should have a order handle$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should be able to move the second feature to the first position$/ do
  pending # express the regexp above with the code you wish you had
end
