require "find"

Given /^there is a project$/ do
  @project = Project.new(:title=>"A project",
              :description=>"This is a description",
              :aim=>"the aim of our project is...",
              :created_at => Time.now.yesterday)
  @project.save
end

Given /^I visit the projects edit view$/ do
  visit("/projects/#{@project.id}/edit")
end

Given /^there are projects$/ do
  @projects = Project.find :all
end

Given /^the project does not have a project location$/ do
 @project.stub!(:location).and_return nil
end

Given /^the project does have a project location$/ do
  @project.update_attribute(:location,"#{RAILS_ROOT}")
end

Given /^a step already exists$/ do
  response.should contain Step.find(4).title
end

Given /^there are no features to import$/ do
  Project.stub(:find_features).and_return []
end

Given /^there are no projects$/ do
  @projects = Project.stub(:last).and_return nil
end

When /^the project already exists$/ do
  @project.stub!(:save).and_return false
end

When /^the project is viewed$/ do
  visit "/projects/#{@project.id}"
end

When /^the project is not able to update$/ do
  @project.stub!(:update_attributes).and_return false
end

When /^I visit the projects index page$/ do
  visit('/projects')
  assigns[:projects] = @projects
end

When /^we view the second projects features$/ do
  visit('/projects/2/features')
end

When /^I visit the second projects features$/ do
  visit('/projects/2/features')
end

When /^I create new a feature$/ do
  click_link 'New feature'
end

When /^a project has no features$/ do
  assert Project.find(1).feature_ids.empty?
end

When /^I visit the project$/ do
  visit('/projects/2/features')
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

Then /^submit the form$/ do
	
  click_button 'Save'
end

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
  response.should have_selector(:p, :content =>"This is a description")
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
  check 'project_feature_ids_'
end

Then /^the project features page will be displayed$/ do
  response.should have_selector :ul do |list|
    Project.find(1).features.each do |feature|
      list.should have_selector :li do |content|
        content.should contain => feature.title
      end
    end
  end
end

Then /^a summary of the project should be displayed$/ do
  @project = Project.find 2
  response.should have_selector :div, attribute = {:class=>"info"} do |project_info|
    project_info.should have_selector :span, :content => @project.title
    project_info.should have_selector :span, :content => @project.description
    project_info.should have_selector :span, :content => @project.aim
  end
end

Then /^I should be sent to the new feature page$/ do
  response.should have_selector :form
end

Then /^the project should already be selected$/ do
  response.should have_selector :input, atrribute = {:type=>"checkbox",:value=>"1",:id=>"project_id_1"}
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
  response.should have_selector :li do |list|
    list.should have_selector :span, attribute = {:class=>"icons"} do |content|
      content.should have_selector :a do |link|
        link.should contain "New Feature"
      end
    end
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
  response.should contain "#{@project.creation_date}"
end

Then /^the projects date should be updated$/ do
  @project = Project.find_by_title "A different title"
  @project.updated_at.should_not be nil
end

Then /^the projects updated field will be displayed$/ do
  response.should contain "Updated at: #{@project.updated_date}"
end

Then /^the projects updated field will not be displayed$/ do
  response.should_not contain "Updated at:"
end

Then /^I should see a import link$/ do
  response.should have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
end

Then /^I should not see a import link$/ do
  response.should_not have_selector :a, attribute = {:href => "/projects/#{@project.id}/import"}
end

Then /^I should see a list of features that will be imported$/ do
  @project = Project.find(1)
  @project.update_attribute(:location,"#{RAILS_ROOT}")
  response.should have_selector :ul do |list|
    @project.find_features do |feature|
      list.should have_selector :li do |content|
        content.should contain "#{feature}"
      end
    end
  end
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

When /^select the features feature$/ do
  click_link 'feature import'
end

When /^the feature is visible$/ do
  response.should have_selector :div, attribute = {:id => "projects_feature"}
end

When /^we click import projects$/ do
  click_button 'Import projects'
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
  response.should have_selector :b, :content => "#{Step.find(4).title}"
end

Then /^each imported stories step should be added$/ do
  assert(Step.find_by_title("Given I can view the projects page").title)
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
	click_link 'Edit project'
end
