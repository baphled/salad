Then /^I should see a import link$/ do
  response.should have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
end

Then /^I should not see a import link$/ do
  response.should_not have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
end

# Refactor to help speed things up
Then /^I should see a list of features that will be imported$/ do
  @project.update_attribute(:location,"#{RAILS_ROOT}")
  response.should have_selector :ul do |list|
    @project.import_features do |feature|
      list.should have_selector :li do |content|
        content.should contain "#{feature[:feature].title}"
      end
    end
  end
end

Then /^each of the features tabs should not include any underscores$/ do
    @project.update_attribute(:location,"#{RAILS_ROOT}")
    response.should have_selector :ul do |list|
    @project.import_features do |feature|
      list.should have_selector :li do |content|
        content.should have_selector :a, :content => "#{feature[:file].sub(/\.feature/,"").gsub(/_/," ")}"
      end
    end
  end
end

Then /^each of the features title should not include any underscores$/ do
  @project.update_attribute(:location,"#{RAILS_ROOT}")
  response.should have_selector :form do |content|
    @project.import_features do |feature|
      content.should have_selector :h3, :content  => "Feature: #{feature[:file].sub(/\.feature/,"").gsub("_"," ")}"
    end
  end
end