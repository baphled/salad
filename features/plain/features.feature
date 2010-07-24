Feature: A user should be able to add features to the system
  In order to create a project with features
  As a user I need to be able to create features
  I want to be able to create new features and associate them with projects if I wish

  Scenario: I should be able to create a new feature
    When I am on "new feature"
    And I fill in the feature form
    Then submit the form
    And the feature information should be saved
    And I should be redirected to the new features
    And a flash message 'was created' should be displayed

  Scenario: When I create a feature with no title, the feature should not be valid
    When I am on "new feature"
    And I don't fill in the features "title"
    Then submit the form
    And I should be redirected to the form
    And a form error must be displayed
    And the user should be told the must have a title
	
  Scenario: When I create a feature I should be able to associate the feature to a project
    When I am on "new feature"
    And there are features
    And I fill in the feature form
    Then I should have a checkable list of projects
    And submit the form
    And the feature information should be saved
    And I should be redirected to the new feature

  Scenario: I should be able to visit the features index page and view all the features in the application
    Given there are features
    When I am on "all features"
    Then I should see a list of features
    And the list should contain features

  Scenario: I should be able to edit a feature
    Given there is a feature
    When I am on "edit feature"
    And we fill in the feature title with 'an edited title'
    And submit the form
    Then the feature should be saved
    And I should be redirected to the new feature
    And the flash message 'Feature: my first feature, was updated'

  Scenario: Invalid feature update should not be saved
    Given there is a feature
    When I am on "edit feature"
    And I don't fill in the features "title"
    And submit the form
    Then the form should be rerendered
    And the flash message 'Feature: my first feature, was not updated'

  Scenario: Should be able to create a new story for a feature
    Given there is a feature
    When I am on "a feature"
    Then I should be able to add a new story
    And the features information should be displayed above the form

  Scenario: I should be able to view all stories associated to a given feature
    Given there is a feature
    And the first feature has stories
    When I am on "features stories"
    Then I can view all the stories associated to the feature

  Scenario: It should have a 'In order' field
    When I am on "new feature"
    And we fill in the feature in_order with 'to create the best app'

  Scenario: It should have a 'As a' field
    When I am on "new feature"
    And we fill in the feature as_a with 'user'

  Scenario: It should have a 'I want' field
    When I am on "new feature"
    And we fill in the feature i_want with 'the best project ever'

  Scenario: It must have the 'In order' field filled
    When I am on "new feature"
    And we fill in the feature in_order with 'to create the best app'

  Scenario: It must have the 'As a' field filled
    When I am on "new feature"
    And we fill in the feature title with 'Logging in'
    And we fill in the feature in_order with 'to create the best app'
    And we fill in the feature i_want with 'the best project ever'
    Then submit the form
    And I should be redirected to the form
    And a form error must be displayed

  Scenario: It must have the 'I want' field filled
    When I am on "new feature"
    And I don't fill in the features "i_want"
    Then submit the form
    And I should be redirected to the form
    And a form error must be displayed

  Scenario: It must be able to view all features creation date
    Given there are features
    When I am on "all features"
    Then each of the features should have a creation date

  # @TODO Refactor so that the steps actually do what the scenario says
  Scenario: I should be able to edit a feature the projects date should be updated
    Given there is a feature
    When I am on "edit feature"
    And we fill in the feature title with 'A different title'
    Then submit the form
    And the features date should be updated

  Scenario: It's date should be updated when I edit it
    Given there is a feature
    When I am on "edit feature"
    When we fill in the feature title with 'A different title'
    Then submit the form
    And the title should now be 'A different title'
    And the features date should be updated
    And the features updated field will be displayed

  Scenario: It should have stories
    Given there is a feature
    And there are stories
    When I am on "edit feature"
    When the feature has stories
    Then the stories should be listed
    
  Scenario: A selected story should be stored when a new feature is created
    Given there is a feature
    And the "feature" has 5 "stories"
    When I am on "edit feature"
    When we fill in the feature title with 'A different title'
    Then the stories should be listed
    When I uncheck a story
    Then submit the form
    And the feature should be not associated to the story
    
  Scenario: I should be able to edit the feature I am viewing
    Given there is a feature
    When I am on "a feature"
    Then there should be an edit link

  Scenario: When a feature stored on system has a path stored I should be able to easily view the feature file
    Given there is a feature
    And the feature has a valid path
    When I am on "a feature"
    And click the features path
    Then the feature files contents should be viewable