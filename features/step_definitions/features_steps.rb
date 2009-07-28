When /^fill in the new feature with no errors$/ do
  fill_in 'feature_title', :with => 'Logging in'
  fill_in 'feature_body', :with => 'When a user successfully logs in'
end

Then /^the feature information should be saved$/ do
  assert_response :success
end

Then /^I should have a checkable list of projects$/ do
  Project.find(:all).each do |project|
    response.should contain project.title
    response.should have_selector :input
  end
end

When /^don't fill in the feature title$/ do
  fill_in 'feature_body', :with => 'When a user successfully logs in'
end

When /^don't fill in the feature body$/ do
  fill_in 'feature_title', :with => 'Logging in'
end

When /^there are features$/ do
  assert Feature.find :all
end

When /^I visit the index features page$/ do
  visit('/features')
end

Then /^I should see a list of features$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li
  end
end

Then /^the list should contain features$/ do
  Feature.all.each do |feature|
    response.should have_selector :div, attribute = {:class=>"feature"} do |content|
      content.should contain feature.title
      content.should contain feature.body
    end
  end
end