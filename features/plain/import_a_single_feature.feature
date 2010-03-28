Feature: Import a single feature
  In order to help keep our features up to date we want an easy way to import a single feature
  As a user
  I want to be able to import a single feature
  
  Scenario: When a feature is not on the system and there is a new feature file, we should have the option to import it
    Given we have a valid feature file
    And the feature is not found
    When there is a project
    And the project single import is viewed
    Given the feature file is not present in the system
    Then we want to be able to import the feature
    
  Scenario: When importing a feature we should be able to click import and then be redirected to the new feature
    Given we have a valid feature file
    And the feature is not found
    When there is a project
    And the project single import is viewed
    And we click the "Import tag cloud" feature
    Then the feature should be displayed
    When we submit the new feature
    Then the feature should be save
    
  Scenario: We need to make sure that we do not import a feature that is already added to the system
    Given we have a valid feature file
    And the feature is not found
    When there is a project
    And the project single import is viewed
    And we click the "Import tag cloud" feature
    Then the feature should be displayed
    When we submit the new feature
    Then the feature should be save
  
  
  