Given /^the first feature has stories$/ do
  assert !Feature.find(1).stories.nil?
end

Given /^there is a feature$/ do
  @feature = Feature.first
end

Given /^I visit the features edit view$/ do
  visit("/features/#{@feature.id}/edit")
end

Given /^the feature has stories$/ do
  @feature = Feature.first
end

When /^the feature is viewed$/ do
  visit feature_path @feature
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

When /^there are features$/ do
  assert Feature.find :all
end

When /^I visit the index features page$/ do
  visit('/features')
end

When /^I edit the first feature$/ do
  click_link 'edit_feature_1'
end

When /^I visit the first features stories$/ do
  click_link 'feature_1_stories'
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
  response.should have_selector :ul do |list|
    Feature.find(1).stories.each do |story|
      list.should have_selector :li do |content|
        content.should contain story.scenario
      end
    end
  end
end

Then /^the feature should have a creation date$/ do
  response.should contain "Created at:"
end

Then /^the features date should be updated$/ do
  @feature = Feature.find_by_title "A different title"
  @feature.updated_at.should_not be nil
end


Then /^the features updated field will be displayed$/ do
  response.should contain "Updated at: #{@feature.updated_date}"
end