Feature: Ajax based importing a single feature
  In order to ajaxify our feature imports
  As a user
  I want the imports page to display the features index content
  
  Scenario: We want to be able to see the feature index content when we import a single feature
    Given we have a valid feature file
    And the feature is not found
    And the feature file is not present in the system
    And there is a feature
    When I am on "a feature"
    Then we want to be able to import the feature
    And a list of features should be displayed
    And a list of feature to import should be displayed