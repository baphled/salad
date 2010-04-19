Feature: Import all features
  In order to speed things up when we have a few features
  As a user
  I want to be able to import all features at once

  Scenario: When a user selects update all we will update all features in the background
    Given there is a project
    And the project has a project path
    When I visit the project
    And I follow "Import all"
    Then we should be redirected the the "projects" page
    And the features should be updated in the background