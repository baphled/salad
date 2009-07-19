Feature: We need to a way to store our stories within a project, this will help organise our stories.
  In order to help manage and organise our projects
  As a user I want to be able to create a project
  I want to be able to create a problem which I can view, edit and manage

  Scenario: As a user I need to be able to create a new project
    Given I can view the site
    When I click new project
    And fill in the new project with no errors
    Then submit the form
		And the project information should be saved
    And I should be redirected to the new project
    And a flash message notice should be displayed

  Scenario: As a user I must give a new project a title
    Given I can view the site
    When I click new project
    And don't fill in the title
    Then submit the form
    And I should be redirected to the new project form
    And a form error must be displayed
		And the user should be told the must have a title
		
  Scenario: As a user I must give the project a brief description
	  Given I can view the site
	  When I click new project
	  And don't fill in the description
	  Then submit the form
	  And I should be redirected to the new project form
	  And a form error must be displayed
		And the user should be told the must have a description
		
	Scenario: As a user I must give the project an aim
	  Given I can view the site
	  When I click new project
	  And don't fill in the aim
	  Then submit the form
	  And I should be redirected to the new project form
	  And a form error must be displayed
		And the user should be told the must have a aim
		
  Scenario: As a user I should not be able to create a project that already exists
    Given I can view the site
    When I click new project
    And the project already exists
    And fill in the new project all details
    Then submit the form
    And I should be redirected to the new project form
    And a form error must be displayed
		And the user should be told the project already exists