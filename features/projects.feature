Feature: We need to a way to store our stories within a project, this will help organise our stories.
  In order to help manage and organise our projects
  As a user I want to be able to create a project
  I want to be able to create a problem which I can view, edit and manage

  Scenario: As a user I need to be able to create a new project
    Given I can view the projects page
    When I click new projects
    And fill in the new project with no errors
    Then submit the form
		And the project information should be saved
    And I should be redirected to the new project
    And a flash message 'Project: A project was created' should be displayed

  Scenario: As a user I must give a new project a title
    Given I can view the projects page
    When I click new projects
    And don't fill in the project title
    Then submit the form
    And I should be redirected to the form
    And a form error must be displayed
		And the user should be told the must have a title
		
  Scenario: As a user I must give the project a brief description
	  Given I can view the projects page
	  When I click new projects
	  And don't fill in the description
	  Then submit the form
	  And I should be redirected to the form
	  And a form error must be displayed
		And the user should be told the must have a description
		
	Scenario: As a user I must give the project an aim
	  Given I can view the projects page
	  When I click new projects
	  And don't fill in the aim
	  Then submit the form
	  And I should be redirected to the form
	  And a form error must be displayed
		And the user should be told the must have a aim
		
  Scenario: As a user I should not be able to create a project that already exists
    Given I can view the projects page
    When I click new projects
    And the project already exists
    And fill in the new project all details
    Then submit the form
    And I should be redirected to the form
    And a form error must be displayed
		And the user should be told the project already exists
		
	Scenario: A user should be able to view a single project
	  Given there is a project
	  When it is viewed
	  Then I should be able to view its details
	
	Scenario: A user should be able to edit projects title
	  Given there is a project
		And I visit its edit view
	  When we edit the 'A project' project
	  Then I should be able to edit its title
		And submit the form
		Then project title 'A project' should now be 'A different title'
	
	Scenario: A user should be able to edit projects description
	  Given there is a project
		And I visit its edit view
	  When we edit the 'A description' project
	  Then I should be able to edit its title
		And submit the form
		Then project description 'A description' should now be 'A different description'

	Scenario: A user should be able to edit projects aim
	  Given there is a project
		And I visit its edit view
	  When we edit the 'An aim' project
	  Then I should be able to edit its title
		And submit the form
		Then project aim 'An aim' should now be 'A different aim'

	Scenario: If there is a problem saving the project we should be alerted
	  Given there is a project
	  When I visit its edit view
		And we edit the 'An aim' project
		And the project is not able to update
	  Then the project should not be updated
	
	Scenario: All stories can be linked to a project
  	Given I can view the projects page
	  When I click new projects
		And there are features
		Then I should have a checkable list of features
		And we must be able to select 1 feature	
		And the project information should be saved
    And I should be redirected to the new project

	Scenario: I should be able to click a link which takes me to the projects features
	  Given I can view the projects page
	  When I visit the second projects features
	  Then the project features page will be displayed
	
	Scenario: I should be able to view the project information in details
	  Given I can view the projects page
	  When I visit the second projects features
	  Then the project features page will be displayed
		And a summary of the project should be displayed
	
	Scenario: I should be able to add new features a project within the project features
	  Given I can view the projects page
	  When we view the second projects features
	  Then the project features page will be displayed
		When I create new a feature
		Then I should be sent to the new feature page
		And the project should already be selected
		And the feature information should be saved
	
	Scenario: I should not see a list of features if there are none associated with a project
	  Given I can view the projects page
		When a project has no features
		And I visit the first projects features
	  Then I should not see the project features section
	
	Scenario: I should be able to create a new project via the projects index page
	  Given I can view the projects page
	  Then I should be able to click the new project link
		And be sent to the new projects view
		
	Scenario: I should not be able to see the view project features link unless there are actually features linked to the project
	  Given I can view the projects page
	  When a project has no features
	  Then there should not be a 'view features' link