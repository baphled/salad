Feature: Viewing an item
  In order to keep the item views consistent
  As a user
  I want to see a consistent layout

  Scenario: Viewing a project should display a list of features
    Given the project has features
    And one of the projects features has a path
    When I am on "project show" page
    Then a feature with a path should display it

  Scenario: The features path should be clickable
    Given the project has features
    And one of the projects features has a path
    When I am on "project show" page
    Then the path location should be a link