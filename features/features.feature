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

		Scenario: As a user I should be able to visit the features index page and view all the features in the application
		  Given there are features
		  When I visit the index features page
		  Then I should see a list of features
			And the list should contain features
			
		Scenario: As a user I should be able to edit a feature
		  Given I can view the features page
		  When I edit the first feature
			And the title is edited
			And submit the form
		  Then the feature should be saved
			And I should be redirected to the new feature
			And the flash message 'Feature: my first feature, was updated'
		
		Scenario: A user who sends an invalid feature update 
		  Given I can view the features page
		  When I edit the first feature
			And the title is invalid
			And submit the form
		  Then the form should be rerendered
			And the flash message 'Feature: my first feature, was not updated'
			
		Scenario: A user should be able to create a new story for a feature
		  Given I can view the features page
			And there are features
	    When I select first feature
			Then I should be able to add a new story
			And the features information should be displayed above the form
		
		Scenario: A user should only see a view stories link if the feature has stories associated to it
		  Given I can view the features page
			And there are features
			And the first feature has stories
	    Then I should be able to see the first features stories link
			
		Scenario: I should be able to view all stories associated to a given feature
		  Given I can view the features page
			And there are features
			And the first feature has stories
			When I visit the first features stories
			Then I can view all the stories associated to the feature
			
		Scenario: A feature should have a 'In order' field
		  Given I can view the features page
			And there are projects
	    When I click new features
			And fill in the 'In order' field
	    And fill in the new feature with no errors
			Then submit the form
			And the feature information should be saved
	    And I should be redirected to the new features
	    And a flash message 'Feature: Logging in, was created' should be displayed
	
		Scenario: A feature should have a 'As a' field
		  Given I can view the features page
			And there are projects
	    When I click new features
			And fill in the 'As a' field
	    And fill in the new feature with no errors
			Then submit the form
			And the feature information should be saved
	    And I should be redirected to the new features
	    And a flash message 'Feature: Logging in, was created' should be displayed
	
		Scenario: A feature should have a 'I want' field
		  Given I can view the features page
			And there are projects
	    When I click new features
			And fill in the 'I want' field
	    And fill in the new feature with no errors
			Then submit the form
			And the feature information should be saved
	    And I should be redirected to the new features
	    And a flash message 'Feature: Logging in, was created' should be displayed