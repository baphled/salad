# TODO Make more flexible and speed up
Given /^we have a stories with examples$/ do
  f = FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export
  @story = f.stories.first
  @story.save
end

When /^I select first feature new story link$/ do
  click_link 'new-story'
end

When /^check a pre\-existing step$/ do
  check "#{Step.first.title}"
end

Then /^there should be a list of stories$/ do
  response.should have_selector(:div) do |content|
    content.should have_selector(:ul) do |list|
      list.should have_selector(:li)
    end
  end
end

Then /^each story should have a scenario$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li do |content|
      content.should contain "Scenario"
    end
  end
end

Then /^I should see a list of stories$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li do |content|
      content.should have_selector :div
    end
  end
end

Then /^the features information should be displayed above the form$/ do
  response.should have_selector :div do |content|
    content.should contain @feature.title
  end
end

Then /^I should be see a link to create a new story$/ do
  click_link 'New Story'
end

Then /^it should be saved$/ do
  response.should_not have_selector :form, attribute = {:href=>new_story_path}
end


Then /^we should the example should be displayed$/ do
  response.should have_selector :td, :content => "Examples"
end

When /^I uncheck a story$/ do
  @removed_story = @feature.stories.first
  uncheck "feature_story_id_#{@feature.stories.first.id}"
end

Then /^the feature should be not associated to the story$/ do
  @feature.stories.should_not contain @removed_story
end