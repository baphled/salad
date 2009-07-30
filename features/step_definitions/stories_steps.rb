Given /^there are stories$/ do
  assert !Story.find(:all).nil?
end

When /^I select first feature new story link$/ do
  click_link 'New Story'
end

When /^fill in the new story with no errors$/ do
  fill_in 'story_title', :with => 'a new story'
  fill_in 'story_scenario', :with => 'this is our stories scenario'
end

When /^I select first feature$/ do
  click_link 'View'
end

Then /^there should be a list of stories$/ do
  response.should have_selector :div do |content|
    content.should have_selector :ul do |list|
      list.should have_selector :li
    end
  end
end

Then /^each story should have a title$/ do
  response.should have_selector :ul do |list|
    Story.all.each do |story|
      list.should have_selector :li do |content|
        content.should contain story.title
      end
    end
  end
end

Then /^each story should have a scenario$/ do
  response.should have_selector :ul do |list|
    Story.all.each do |story|
      list.should have_selector :li do |content|
        content.should contain story.scenario
      end
    end
  end
end

Then /^there should not be a list of stories$/ do
  response.should_not have_selector :ul
end

Then /^the story information should be saved$/ do
  assert !Story.find_by_title("a new story").title.nil?
end

Then /^I should see a list of stories$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li do |content|
      content.should have_selector :div
    end
  end
end

Then /^the features information should be displayed above the form$/ do
  @feature = Feature.find 1
  response.should have_selector :div do |content|
    content.should contain @feature.title
    content.should contain @feature.body
  end
end
