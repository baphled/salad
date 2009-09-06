Feature: We need to be able to carry out searches on various parts of the application
  In order to help find items in the application
  As a user
  I want to be able to search for items within salad

	Scenario: I need to be able to search for steps
	  Given I can view the steps page
	  When I search for steps contain 'Given'
		And we click search
	  Then we should have a list of results
		And all results should contain 'Given'
		
	Scenario: We should be able to use the search functionality to add a step to a story
	  Given I can view the stories page
	  When I edit the first story
		And I search for steps contain 'Given'
		And we click search
		And the resulting step should be added to the story
	
	
	