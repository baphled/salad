Feature: Users should not have to manually input their features if they have already defined them within cucumber. Users should be able to select import, to which the system will parse over their features and generate the necessary associations for their project.

  In order to keep our features synchronised
  As a user
  I want the functionality to import my cucumber features into salad

	Scenario: I should be able to import feature into a project
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
	
	Scenario: I should not see an import link if the project location is not present
	  Given there is a project
		And the project does not have a project location
	  When the project is viewed
	  Then I should not see a import link
	
	Scenario: I should be able to click the import link
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		
	Scenario: I should only see files which are actual features
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
