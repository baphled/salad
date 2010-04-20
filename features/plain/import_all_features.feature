Feature: Import all features
  In order to speed things up when we have a few features
  As a user
  I want to be able to import all features at once

  Scenario: When a user selects update all we will update all features
    Given there is a project
    And the project has features to import
    When I visit the project
    And I follow "Import all"
    Then a flash message 'Importing all features' should be displayed
    And there should be no features to import