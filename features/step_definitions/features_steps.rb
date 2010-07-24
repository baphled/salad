Given /^the first feature has stories$/ do
  @feature.stories = [Story.make]
end

Given /^there is a feature$/ do
  @feature = Feature.make
end

Given /^the feature has stories$/ do
  @feature.stories = [Story.make]
end

Given /^the features creation date is not the same as the updated date$/ do
  @feature.update_attribute(:updated_at, Time.now.next_year)
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

# @TODO Centralise step
When /^there are features$/ do
  Feature.stub(:all).and_return [Feature.make]
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

Then /^the flash message '(.*)'$/ do |flash|
  flash.should contain "#{flash}"
end

Then /^the form should be rerendered$/ do
  response.should render_template "edit"
end

Then /^I should be able to add a new story$/ do
  click_link 'New Story'
end

Then /^I should be able to see the first features stories link$/ do
  response.should have_selector :a, attribute = {:href=>"/features/1/stories"}
end

Then /^I can view all the stories associated to the feature$/ do
  response.should have_selector :ul do |list|
    @feature.stories.each do |story|
      list.should have_selector :li do |content|
        content.should contain story.scenario
      end
    end
  end
end

Then /^the features date should be updated$/ do
  @feature = Feature.find_by_title "A different title"
  @feature.updated_at.should_not be nil
end


Then /^the features updated field will be displayed$/ do
  response.should contain "Updated date: #{@feature.updated_date}"
end

Then /^the (.*) should be listed$/ do |item|
  response.should have_selector :ul do |list|
    list.should have_selector :input, attribute = {:type => "checkbox", :name => "feature[#{item.to_s.singularize}_ids][]"}
  end
end

Then /^the feature should be not associated to the first story$/ do
  @feature.stories.should_not contain Feature.first.stories.first
end

Then /^the feature information should be not saved$/ do
  response.should_not contain "was created"
end

Then /^there should be an edit link$/ do
  response.should have_selector :span do |content|
    content.should have_selector :a, attribute = {:title => "Edit the feature and it's stories"}
  end
end

When /^click the features path$/ do
  click_link @feature.path
end

Then /^the feature files contents should be viewable$/ do
  response.should contain "Feature: "
end