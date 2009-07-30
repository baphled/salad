Feature: Stories will be needed to populate our projects features
  In order for a user to populate their features, they will need to be able to create stories and associate these with the desired feature
  As a user
  I want to be able to create stories and associate them with features
		
	Scenario: I should be able to view all stories
	  Given I can view the stories page
		And there are stories
	  Then there should be a list of stories
		And each story should have a title
		And each story should have a scenario
		
	Scenario: As a user I should be able to create a new story
    Given I can view the features page
		And there are features
    When I select first feature new story link
    And fill in the new story with no errors
    Then submit the form
		And the story information should be saved
    And I should be redirected to the new story
    And a flash message 'Feature: Logging in, was created' should be displayed

	Scenario: As a user I should be able to view all the features stories
	  Given I can view the features page
		And there are features
    When I select first feature
		Then I should see a list of stories
		And each story should have a title
		And each story should have a body
	