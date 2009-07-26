When /^fill in the new story with no errors$/ do
  fill_in 'story_title', :with => 'Logging in'
  fill_in 'story_body', :with => 'When a user successfully logs in'
end

Then /^the story information should be saved$/ do
  assert_response :success
end

When /^don't fill in the story title$/ do
  fill_in 'story_body', :with => 'When a user successfully logs in'
end

When /^don't fill in the story body$/ do
  fill_in 'story_title', :with => 'Logging in'
end

Then /^I should have a checkable list of projects$/ do
  Project.find(:all).each do |project|
    response.should contain project.title
    response.should have_selector :input
  end
end
