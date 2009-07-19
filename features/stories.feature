Feature: A user should be able to create new stories, which can be associated with projects
  In order to create a project with stories
  As a user I need to be able to create stories
  I want to be able to create new stories and associate them with projects if I wish

  Scenario: As a user I should be able to create a new story
    Given I can view the stories page
    When I click new stories
    And fill in the new story with no errors
    Then submit the form
		And the story information should be saved
    And I should be redirected to the new story
    And a flash message 'Story: Logging in, was created' should be displayed

  Scenario: As a user when I create a story with no title, the story should not be valid
	  Given I can view the stories page
	  When I click new stories
	  And don't fill in the story title
	  Then submit the form
	  And I should be redirected to the new story form
	  And a form error must be displayed
		And the user should be told the must have a title
		
	Scenario: As a user when I create a story with no body, the story should not be valid
	  Given I can view the stories page
	  When I click new stories
	  And don't fill in the story body
	  Then submit the form
	  And I should be redirected to the new story form
	  And a form error must be displayed
		And the user should be told the must have a title
		
	Scenario: As a user when I create a story I should be able to associate the story to a project
	  Given I can view the stories page
	  When I click new stories
	  And fill in the new story with no errors
		And select a the first project
	  Then submit the form
		And the story information should be saved
	  And a form error must be displayed
		And the user should be told the must have a title