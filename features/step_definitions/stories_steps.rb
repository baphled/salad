When /^fill in the new story with no errors$/ do
  fill_in 'story_title', :with => 'Logging in'
  fill_in 'story_body', :with => 'When a user successfully logs in'
end
