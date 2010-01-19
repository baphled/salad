Given /^I open the projects index page$/ do
  @browser.open('http://localhost:3000/projects')
  @browser.wait_for_element "id=lists"
end

When /^the first project is hovered over$/ do
  @browser.mouse_over("id=project_1")
end

Then /^the project's information will be display in the sidebar$/ do
  @browser.wait_for_visible(id="project_1_feature")
end
