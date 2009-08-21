Feature: Users should not have to manually input their features if they have already defined them within cucumber. Users should be able to select import, to which the system will parse over their features and generate the necessary associations for their project.

  In order to keep our features synchronised
  As a user
  I want the functionality to import my cucumber features into salad

	Scenario: I should be able to import feature into a project
	  Given there is a project
	  When the project is viewed
	  Then I should see a import link
	
	

  
