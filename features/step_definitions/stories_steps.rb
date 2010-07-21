Given /^there are stories$/ do
  @stories = Story.stub(:all).and_return [Story.make]
end

Given /^the story has steps$/ do
  @story ||= Story.first
end

Given /^there is a story$/ do
  @story = Story.make
end

Given /^we have a stories with examples$/ do
  f = FeatureFile.new("#{RAILS_ROOT}/features/plain/enhancements.feature").export
  @story = f.stories.first
  @story.save
  @story.examples.size.should eql 1
end

Given /^it has an associated feature$/ do
  @story.features << Feature.make
end

When /^I select first feature new story link$/ do
  click_link 'New Story'
end

When /^I select first feature$/ do
  click_link 'View'
end

When /^uncheck a feature it is associated to$/ do
  uncheck 'story_feature_id_1'
end

When /^check a pre\-existing step$/ do
  check 'story_step_id_1'
end

When /^I fill in the story form"$/ do
  When %{we fill in the story scenario with 'this is our stories scenario'}
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

Then /^the story information should be saved$/ do
  assert !Story.find_by_scenario("this is our stories scenario").scenario.nil?
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