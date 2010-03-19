Feature: Import a single feature
  In order to help keep our features up to date we want an easy way to import a single feature
  As a user
  I want to be able to import a single feature
  
  Scenario: When a feature is not on the system and there is a new feature file, we should have the option to import it
    Given there is a feature file
    When we got to the features page
    And the feature file is not present in the system
    Then we want to be able to import the feature