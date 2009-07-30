Given /^there are stories$/ do
  assert !Story.find(:all).nil?
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
