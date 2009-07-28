Feature: A user should be able to create new features, which can be associated with projects
  In order to create a project with features
  As a user I need to be able to create features
  I want to be able to create new features and associate them with projects if I wish

  Scenario: As a user I should be able to create a new feature
    Given I can view the features page
		And there are projects
    When I click new features
    And fill in the new feature with no errors
    Then submit the form
		And the feature information should be saved
    And I should be redirected to the new features
    And a flash message 'Feature: Logging in, was created' should be displayed

  Scenario: As a user when I create a feature with no title, the feature should not be valid
	  Given I can view the features page
	  When I click new features
	  And don't fill in the feature title
	  Then submit the form
	  And I should be redirected to the form
	  And a form error must be displayed
		And the user should be told the must have a title
		
	Scenario: As a user when I create a feature with no body, the feature should not be valid
	  Given I can view the features page
	  When I click new features
	  And don't fill in the feature body
	  Then submit the form
	  And I should be redirected to the form
	  And a form error must be displayed
		And the user should be told the must have a body	
	
	Scenario: As a user when I create a feature I should be able to associate the feature to a project
	  Given I can view the features page
	  When I click new features
		And there are features
	  And fill in the new feature with no errors
		Then I should have a checkable list of projects
	  Then submit the form
		And the feature information should be saved
    And I should be redirected to the new feature

		Scenario: As a user I should be able to visit the feautres index page and view all the features in the application
		  Given there are features
		  When I visit the index features page
		  Then I should see a list of features
			And the list should contain features
		
		
		