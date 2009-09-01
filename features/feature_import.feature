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
		
	Scenario: I should be able to save a selected feature to import
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		And select the features feature
		And the feature is visible
		And we click import feature
    Then a flash message 'We need to a way to store our stories within a project, this will help organise our stories.' should be displayed
	
	Scenario: When importing a new feature, we should not add scenarios that already exist
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		And select the features feature
		And the feature is visible
		And a scenario already exists
		Then we scenario should display that is is already added
		And we click import feature
		Then the scenario should not be duplicationed
    And a flash message 'We need to a way to store our stories within a project, this will help organise our stories.' should be displayed
	
	Scenario: All scenario's should display the steps associated to it
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features its stories
		And each story should display its steps
		
	Scenario: When should be able to view all 'Given' steps
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features its stories
		And each story should display its steps
		And the feature should have at least on 'Given'
		
	Scenario: When should be able to view all 'When' steps
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features its stories
		And each story should display its steps
		And the feature should have at least on 'When'
		
	Scenario: When should be able to view all 'Then' steps
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features its stories
		And each story should display its steps
		And the feature should have at least on 'Then'
		
	Scenario: A step should be highlighted if it already exists in the system
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And each entry should be a feature file
		And each entry should display the features its stories
		And each story should display its steps
		Given a step already exists
		Then it should be highlighted
		
	Scenario: All steps should be added
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And we click import feature
    Then a flash message 'We need to a way to store our stories within a project, this will help organise our stories.' should be displayed
		And each imported stories step should be added
		
	Scenario: A feature should not be viewable if the feature is already added
	  Given there is a project
		And the project does have a project location
	  When the project is viewed
	  Then I should see a import link
		When I click import
		Then I should see a list of features that will be imported
		And we click import feature
    Then a flash message 'We need to a way to store our stories within a project, this will help organise our stories.' should be displayed
		And each imported stories step should be added
		When the project is viewed
	  Then I should see a import link
		When I click import
		Then the project feature will be not be selectable.
		
	Scenario: A message should be displayed to the user if there are no features to import
		  Given there is a project
			And the project does have a project location
			And there are no features to import
		  When the project is viewed
		  Then I should see a import link
			When I click import
			Then the message 'No features to import.' should be displayed
	
	
	
	
	