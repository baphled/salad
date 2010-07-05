Given /^there is a project$/ do
  @project = Project.first
end

Given /^I visit the projects edit view$/ do
  visit("/projects/#{@project.id}/edit")
end

Given /^there are projects$/ do
  @projects = Project.find(:all)
  @projects.should_not be_empty
end

Given /^the project does not have a project location$/ do
 @project.update_attribute(:location,"")
end

Given /^the project does have a project location$/ do
  @project.update_attribute(:location, "#{RAILS_ROOT}/spec/fixtures/")
end

Given /^a step already exists$/ do
  response.should contain "Then the tags cloud should be displayed"
end

Given /^there are no features to import$/ do
  Project.stub(:find_features).and_return []
end

Given /^there are no projects$/ do
  @projects = Project.stub(:last).and_return nil
end

#TODO refactor so that the steps action is clearer
Given /^the project has features$/ do
  @project = Project.find 2
end

Given /^the project does have a project location to an invalid feature$/ do
  @project.update_attribute(:location,"#{RAILS_ROOT}/spec/fixtures")
end

Given /^the projects creation date is not the same as the updated date$/ do
  @project.update_attribute(:updated_at, Time.now.next_year)
end

Given /^the project has features to import$/ do
  Feature.stub!(:imports_found).with("#{RAILS_ROOT}")
end

Given /^the project does have a project location with no features to import$/ do
  @project.update_attribute(:location,"#{RAILS_ROOT}/spec/fixtures/features")
end

When /^the project already exists$/ do
  @project.should_receive(:save).and_return false
end

When /^the project is viewed$/ do
  visit project_path @project
end

When /^I view the project$/ do
  When %{the project is viewed}
end

When /^the project is not able to update$/ do
  @project.stub!(:update_attributes).and_return false
end

When /^I visit the projects index page$/ do
  visit projects_path
end

When /^I visit the projects features$/ do
  visit features_project_path @project
end

Given /^the "([^\"]*)" has "([^\"]*)"$/ do |model, assoc|
  case model
    when /project/
      @project = Project.find 2
    else
      raise "Can't instantiate \"#{model}\".\n" +
        "Now, go and add a mapping in #{__FILE__}"
  end
end

When /^I create new a feature$/ do
  click_link 'New feature'
end

When /^a project has no features$/ do
  Project.stub(:features).and_return []
end

When /^I visit the project$/ do
  # Project.stub(:find).and_return @project
  visit project_path @project
end

When /^I visit the first projects features$/ do
  visit('/projects/1/features')
end

When /^add 'project, new project' as tags$/ do
  fill_in 'project_tag_list', :with => 'project, new project'
end

When /^I click import$/ do
  click_link 'Import'
end

When /^we fill in the features tags$/ do
  fill_in 'feature_tag_list', :with => 'new feature, something cool'
end

When /^we fill in the project location$/ do
  fill_in 'project_location', :with => "#{RAILS_ROOT}"
end

When /^the project single import is viewed$/ do
  visit import_feature_project_path @project
end

When /^I visit the "([^\"]*)" "([^\"]*)"$/ do |model, assoc|
  case model
    when /projects/
      visit features_project_path @project
    else
      raise "Unable to find path for \"#{model}\" associated to \"#{assoc}\".\n" +
        "Now, go and add a mapping in #{__FILE__}"
  end
end

Then /^submit the form$/ do
  click_button 'save'
end

#TODO Refactor to make more explicit
Then /^the project information should be saved$/ do
  assert_response :success
end

Then "I should be redirected to the new $controller" do |controller|
  current_url.should_not eql "/#{controller}/new"
end


Then /^I should be redirected to the form$/ do
  response.should have_selector :form
end

Then /^a form error must be displayed$/ do
  response.should have_selector :div, attribute = {:class => "errorExplanation"}
end

Then /^the user should be told the must have a (.*)$/ do |value|
  response.should contain "#{value.capitalize} can't be blank"
end

Then /^the user should be told the project already exists$/ do
  response.should contain "Title has already been taken"
end

Then /^I should be able to view its details$/ do
  response.should have_selector(:span, :content => @project.description)
end


Then /^the title should now be '(.*)'$/ do |content|
  response.should contain "#{content}"
end

Then /^project description 'A description' should now be 'A different description'$/ do
  response.should contain 'A different description'
end

Then /^project aim 'An aim' should now be 'A different aim'$/ do
  response.should contain 'A different aim'
end

Then /^the project should not be updated$/ do
  response.should have_selector :form
end

Then /^I should not view a list of projects$/ do
  response.should_not have_selector :ul do |list|
    list.should_not have_selector :li
  end
end

Then /^should see a message saying 'No projects available'$/ do
  response.should have_selector :span, :content => "No projects available"
end

Then /^I should have a checkable list of features$/ do
  Feature.find(:all).each do |story|
    response.should contain story.title
    response.should have_selector :input
  end
end

Then /^we must be able to select 1 feature$/ do
  check 'project_feature_id_1'
end

Then /^the project features page will be displayed$/ do
  response.should have_selector :ul, attribute = {:id => 'features'} do |list|
    @project.features.each do |feature|
      list.should have_selector :li do |content|
        content.should contain feature.title
      end
    end
  end
end

Then /^a summary of the project should be displayed$/ do
  response.should have_selector :div do |project_info|
    project_info.should have_selector :span, :content => @project.title
    project_info.should have_selector :span, :content => @project.description
    project_info.should have_selector :span, :content => @project.aim
  end
end

Then /^I should be sent to the new feature page$/ do
  response.should have_selector :form
end

Then /^the project should already be selected$/ do
  response.should have_selector :input, atrribute = {:type=>"checkbox",:value=>"1",:id=>"feature_project_id_1"}
end

Then /^I should not see the project features section$/ do
  response.should_not have_selector :div, attribute = {:id=>"features"} do |feature|
    feature.should_not have_selector :ul
  end
end

Then /^I should be able to click the new project link$/ do
  click_link 'New project'
end

Then /^be sent to the new projects view$/ do
  response.should have_selector :form, attribute = {:action=>"/projects",:method=>"post"}
end

Then /^there should not be a 'view features' link$/ do
  response.should_not have_selector :a, attribute = {:href=>"/projects/1/features"} do |content|
    content.should_not contain "Feature"
  end
end

Then /^all projects should have a 'Add features' link$/ do
  response.should have_selector :li do |content|
    content.should have_selector :a, attribute ={:title => 'New Feature'}
  end
end

Then /^I should be able to visit the URL$/ do
  visit('/features/new?id=new_project_feature_1')
end

Then /^the project should have link to create new features$/ do
  response.should have_selector :a, attribute = {:href => new_feature_path}
end

Then /^the order button should not be displayed$/ do
  response.should_not have_selector :span, attribute = {:id => "order_icon"}
end

Then /^the project creation date should be stored$/ do
  @project = Project.find_by_title "A project"
  @project.created_at.should_not be nil
end

Then /^each of the (.*) should have a creation date$/ do |controller|
  response.should contain "Created at:"
end

Then /^the project should have a creation date$/ do
  response.should contain "Creation date:"
end

Then /^the projects date should be updated$/ do
  @project = Project.find_by_title "A different title"
  @project.updated_at.should_not be nil
end

Then /^the projects updated field will be displayed$/ do
  response.should contain "Updated date: #{@project.updated_date}"
end

Then /^the projects updated field will not be displayed$/ do
  response.should_not contain "Updated date:"
end

Then /^each entry should be a feature file$/ do
  response.should_not have_selector :li, :content => " . " or ".." or "support" or "step_definitions"
end

Then /^each entry should display the features feature text$/ do
  response.should have_selector :div do |list|
    list.should have_selector :div
  end
end

Then /^each entry should not have 'Feature:' as a prefix$/ do
  response.should_not =~ /^Feature: /
end

Then /^each entry should display the features '(.*)' text$/ do |expected|
  response.should have_selector :div do |content|
    content.should contain "#{expected}"
  end
end

Then /^each entry should display the features its stories$/ do
  response.should have_selector :li  do |content|
    content.should contain "Scenario: "
  end
end

When /^a scenario already exists$/ do
  response.should contain "Scenario: #{Story.find(3).scenario}"
end

When /^select the "([^\"]*)"$/ do |link|
  click_link 'Tag cloud'
end

When /^the feature is visible$/ do
  response.should have_selector :div do |content|
    content.should have_selector :h3, :content => "Feature: tag cloud"
  end
end

When /^we click import projects$/ do
  click_button 'Import tag cloud'
end

Then /^we scenario should display that is is already added$/ do
  response.should have_selector :b, :content => "Already added"
end

Then /^the scenario should not be duplicationed$/ do
  response.should_not have_selector :input, 
                                  attribute = {:value => "Scenario: As a user I must give the project a brief description"}
end

Then /^each story should display its steps$/ do
  response.should have_selector :ul, attribute = {:class => "steps"}
end

Then /^the feature should have at least on '(.*)'$/ do |step_prefix|
  response.should have_selector :ul, attribute = {:class => "steps"} do |step|
    step.should contain step_prefix 
  end
end

Then /^it should be highlighted$/ do
  response.should have_selector :b, :content => "Then the tags cloud should be displayed"
end

Then /^each imported stories step should be added$/ do
  assert(Step.find_by_title("Then the tags cloud should be displayed").title)
end

Then /^the project feature will be not be selectable\.$/ do
  response.should_not have_selector :div,
                                      attribute = {:id => "feature_project"}
end

Then /^we should be redirected to the projects import page$/ do
  current_url.should =~ /import/
end

When /^we visit the new feature$/ do
  feature = Feature.find_by_title("We need to a way to store our stories within a project, this will help organise our stories.")
  visit feature_path(feature)
end

When /^we export the features$/ do
  click_link 'export feature'
end

Then /^I should be able to edit a the project information$/ do
	click_link 'Allows you to edit a projects information'
end

Then /^the project has an invalid feature$/ do
  response.should have_selector(:li) do |content|
      content.should contain "Failing feature"
  end
end

Then /^the submit button will be disabled for that feature$/ do
  response.should_not have_selector :input, attribute = {:value => "Import failing feature"}
end

Then /^the submit button will be disabled for that feature "([^\"]*)"$/ do |button_name|
  response.should_not have_selector :input, attribute = {:value => "#{button_name}"}
end

Then /^it should include features from all sub directories within the feature directory$/ do
  response.should contain "Feature: most used"
end

Then /^the "([^\"]*)" "([^\"]*)" "([^\"]*)" should have an error class$/ do |model, attribute, input|
  response.should have_selector :li, attribute = {:id => "#{model}_#{attribute}_#{input}"} do |content|
    content.should have_selector :ul, attribute = {:class => "errors"}
  end
end

Then /^the error message should be "([^\"]*)"$/ do |message|
  response.should have_selector :ul, attribute = {:class => "errors"} do |content|
    content.should contain "#{message}"
  end
end

Then /^the project information should not be saved$/ do
  response.should have_selector :form
end

Then /^there should be no features to import$/ do
  Feature.imports_found("#{RAILS_ROOT}").should be_nil
end