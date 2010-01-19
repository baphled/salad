When /^the first project is hovered over$/ do
  selenium.mouse_over("project_2")
end

Then /^the project's information will be display in the sidebar$/ do
  selenium.wait_for_visible("project_2_feature")
end