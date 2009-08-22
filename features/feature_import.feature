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
		
	Scenario: I should be able to view the feature text below the file name of each feature file
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features feature text
		
	Scenario: I should not see 'Feature:' in the import display text
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features feature text
		And each entry should not have 'Feature:' as a prefix
	
	Scenario: I should display the 'In order' line
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features 'In order' text
	
	Scenario: I should display the 'As a' line
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features 'As a' text
		
	Scenario: I should display the 'I want' line
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features 'I want' text
		
	Scenario: I should be able to see all the stories for each feature
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features its stories
