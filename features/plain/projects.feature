Feature: We need to a way to store our stories within a project, this will help organise our stories.
  In order to help manage and organise our projects
  As a user
  I want to be able to create a problem which I can view, edit and manage

  Scenario: As a user I need to be able to create a new project
    When I am on "new project"
    And I fill in the project form
    Then submit the form
    And the project information should be saved
    And I should be redirected to the new project
    And a flash message 'Project: A project was created' should be displayed

  Scenario Outline: Not furfilling the forms required fields results in a validation error
    When I am on "new project"
    And I don't fill in the projects "<field>"
    Then submit the form
    And I should be redirected to the form
    And a form error must be displayed
    And the user should be told the must have a <field>

  Examples: Fields that are required
    | field       |
    | title       |
    | description |
    | aim         |

  Scenario: A user should be able to view a single project
    Given there is a project
    When I am on "a project"
    Then I should be able to view its details
	
  Scenario: A user should be able to edit projects title
    Given there is a project
    When I am on "edit project"
    And we fill in the project title with 'A different title'
    Then submit the form
    And the title should now be 'A different title'
	
  Scenario: A user should be able to edit projects description
    Given there is a project
    When I am on "edit project"
    And we fill in the project description with 'A different description'
    And submit the form
    Then project description 'A description' should now be 'A different description'

  Scenario: A user should be able to edit projects aim
    Given there is a project
    When I am on "edit project"
    And we fill in the project aim with 'A different aim'
    And submit the form
    Then project aim 'An aim' should now be 'A different aim'

  Scenario: If there is a problem saving the project we should be alerted
    Given there is a project
    When I visit the projects edit view
    And we fill in the project aim with 'A different aim'
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
    Given there is a project
    When I am on "projects features"
    Then the project features page will be displayed

  Scenario: I should be able to view the project information in detail
    Given there is a project
    And the project has features
    When I am on "projects features"
    Then the project features page will be displayed
    And a summary of the project should be displayed

  Scenario: I should be able to add new features a project within the project features
    Given I can view the projects page
    And there is a project
    When I am on "projects features"
    Then the project features page will be displayed
    When I create new a feature
    Then I should be sent to the new feature page
    And the project should already be selected
    And the feature information should be saved

  Scenario: I should not see a list of features if there are none associated with a project
    Given there is a project
    And a project has no features
    When I am on "projects features"
    Then I should not see the project features section

  Scenario: I should be able to create a new project via the projects index page
    When I am on "all projects"
    Then I should be able to click the new project link
    And be sent to the new projects view

  Scenario: I should be able to easily create new features for a project
    When I am on "all projects"
    Then all projects should have a 'Add features' link
    And I should be able to visit the URL

  Scenario: I should be able to create a project with tags
    When I am on "new project"
    And I fill in the project form
    And add 'project, new project' as tags
    Then submit the form
    And the project information should be saved
    And I should be redirected to the new project
    And a flash message 'Project: A project was created' should be displayed

  Scenario: When creating a new project the user should be directed to it and be able to add features
    When I am on "new project"
    And I fill in the project form
    And add 'project, new project' as tags
    Then submit the form
    And the project information should be saved
    And I should be redirected to the new project
    And a flash message 'Project: A project was created' should be displayed
    And the project should have link to create new features

  Scenario: When viewing a project with no feature, the user should not see the order button
    Given there is a project
    When I am on "a project"
    When a project has no features
    And there is a project
    And the project is viewed
    Then the order button should not be displayed

  Scenario: When a project is created it should store its creation date
    When I am on "new project"
    And I fill in the project form
    Then submit the form
    And the project information should be saved
    And the project creation date should be stored
    And I should be redirected to the new project
    And a flash message 'Project: A project was created' should be displayed

  Scenario: A user must be able to view all projects creation date
    Given there are projects
    When I am on "all projects"
    Then each of the projects should have a creation date

  Scenario: A user must be able to see a projects creation date
    Given there is a project
    When I am on "a project"
    Then the project should have a creation date

  Scenario: When a user edits a project the projects date should be updated
    Given there is a project
    And I visit the projects edit view
    When we fill in the project title with 'A different title'
    Then submit the form
    And the title should now be 'A different title'
    And the projects date should be updated

  Scenario: When a user edits a project the project's updated date with be displayed
    Given there is a project
    When I am on "edit project"
    And we fill in the project title with 'A different title'
    Then submit the form
    And the title should now be 'A different title'
    And the projects date should be updated
    And the projects updated field will be displayed

  Scenario: A user should not display the date the project was updated if it is the same as the creation date
    When I am on "new project"
    And I fill in the project form
    Then submit the form
    And the project information should be saved
    And I should be redirected to the new project
    And a flash message 'Project: A project was created' should be displayed
    And the projects updated field will not be displayed

  Scenario: A user can specify the location of a given project
    When I am on "new project"
    And I fill in the project form
    Then submit the form
    And the project information should be saved
    And I should be redirected to the new project
    And a flash message 'Project: A project was created' should be displayed

  Scenario: A user can edit a project when it is being viewed
    Given there is a project
    When I am on "a project"
    Then I should be able to edit a the project information
