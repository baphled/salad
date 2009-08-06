Given /^the first feature has stories$/ do
  assert !Feature.find(1).stories.nil?
end

When /^fill in the new feature with no errors$/ do
  fill_in 'feature_title', :with => 'Logging in'
  fill_in 'feature_in_order', :with => 'to create the best app'
  fill_in 'feature_as_a', :with => 'user'
  fill_in 'feature_i_want', :with => 'the best project ever'
end

When /^do not fill in the 'As a' field$/ do
  fill_in 'feature_title', :with => 'Logging in'
  fill_in 'feature_in_order', :with => 'to create the best app'
end

When /^do not fill in the 'I want' field$/ do
  fill_in 'feature_title', :with => 'Logging in'
  fill_in 'feature_in_order', :with => 'to create the best app'
  fill_in 'feature_as_a', :with => 'user'
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

end

When /^there are features$/ do
  assert Feature.find :all
end

When /^I visit the index features page$/ do
  visit('/features')
end

When /^I edit the first feature$/ do
  click_link 'edit_feature_1'
end

When /^the title is edited$/ do
  fill_in 'feature_title', :with => 'an edited title'
end

When /^the title is invalid$/ do
  fill_in 'feature_title', :with => ''
end

When /^I visit the first features stories$/ do
  click_link 'feature_1_stories'
end

When /^fill in the 'In order' field$/ do
  fill_in 'feature_in_order', :with => 'to create a new feature'
end

When /^fill in the 'As a' field$/ do
  fill_in 'feature_as_a', :with => 'user'
end

When /^fill in the 'I want' field$/ do
  fill_in 'feature_i_want', :with => 'to be able to create a greate app'
end

When /^do not fill in the 'In order' field$/ do
  fill_in 'feature_title', :with => 'a feature'
  fill_in 'feature_as_a', :with => 'user'
  fill_in 'feature_i_want', :with => 'the world'
end

Then /^I should see a list of features$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li
  end
end

Then /^the list should contain features$/ do
  Feature.all.each do |feature|
    response.should have_selector :div do |content|
      content.should contain feature.title
    end
  end
end

Then /^the feature should be saved$/ do
  assert !Feature.find_by_title("an edited title").title.nil?
end

Then /^the flash message 'Feature: my first feature, was updated'$/ do
  flash.should contain "Feature: my first feature, was updated"
end

Then /^the form should be rerendered$/ do
  response.should render_template("edit")
end

Then /^the flash message 'Feature: my first feature, was not updated'$/ do
  flash.should contain "Feature: my first feature, was not updated"
end

Then /^I should be able to add a new story$/ do
  click_link 'New Story'
end

Then /^I should be able to see the first features stories link$/ do
  response.should have_selector :a, attribute = {:href=>"/features/1/stories"}
end

Then /^I can view all the stories associated to the feature$/ do
  response.should have_selector :ul, attribute = {:id => "stories"} do |list|
    Feature.find(1).stories.each do |story|
      list.should have_selector :li do |content|
        content.should contain story.title
      end
    end
  end
end
