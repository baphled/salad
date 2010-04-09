Given /^the project has a feature to export with duplicate scenarios$/ do
  Given %{we have a valid feature file}
end

Given /^the project has a project path$/ do
  @project.update_attribute(:location,"#{RAILS_ROOT}/spec/fixtures")
end

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

Then /^the first story should contain its examples$/ do
  @project.update_attribute(:location,"#{RAILS_ROOT}")
  @project.import_features do |feature|
    if feature[:file] == 'most_used.feature'
      response.should contain feature[:feature].stories.first.examples.first
    end
  end
  response.should contain 'Examples'
end

Then /^the features scenario "([^\"]*)" should be saved$/ do |content|
  Example.first.heading.should eql content
end

Then /^the submit button will be disabled for "([^\"]*)"$/ do |container|
  response.should have_selector :p, attribute = {:id => "error"} do |error|
    error.should contain "Feature has duplicate scenario"
  end
end

Then /^display the feature file for "([^\"]*)" already exists$/ do |feature_file|
  response.should have_selector :p, attribute = {:id => "error"} do |error|
    error.should contain "Feature already exists in #{RAILS_ROOT}/spec/fixtures/features/duplicates/sample_one.feature"
  end
end
