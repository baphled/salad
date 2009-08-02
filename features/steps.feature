Feature: Stories have steps, which help to define what the action taken within a step
  In order to associate steps with stories, we need to be able to create steps and link them to stories
  As a user
  I want to be able to create new steps which I can associate with stories

	Scenario: A user must be able to create a new step
	  Given I can view the projects page
	  When I create a new step
	  Then the new step form should be displayed
	
	Scenario: A user should be able to successfully create a new step
	  Given I can view the projects page
	  When I create a new step
	  Then the new step form should be displayed
		When I fill in the steps text field
	 	Then submit the form
		And the step should be saved
		And a flash message 'Step: a new step was created', should be displayed.
		
	Scenario: A user should not be able to create a new step if it is not unique
		Given I can view the projects page
	  When I create a new step
	  Then the new step form should be displayed
		When I fill in the steps text field
		Then submit the form
		When I click create a new step
	  Then the new step form should be displayed
		When I fill in the steps text field
		And submit the form
		Then the step should be not saved
		
	Scenario: A user should be able to associate a step with a story
		Given I can view the projects page
	  When I create a new step
	  Then the new step form should be displayed
		When I fill in the steps text field
		And I check 'the first story'
	 	Then submit the form
		And the step should be associated with the story.
		
	Scenario: A user should be able to create a new step via a story
		Given I can view the features page
		And there are features
    When I select first feature
		And I create a new step
		When I fill in the steps text field
		Then submit the form
		And the step should be saved
		And a flash message 'Step: a new step was created', should be displayed.