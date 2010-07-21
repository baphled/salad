Feature: Hovering over a project item
    In order to view more information when hovering over an item
    As a user
    I want to be able to hover over the item, which in turn displays more information

  Scenario: Hovering over a project item from the projects index
    Given there are projects
    When I am on "all projects"
    And the first project is hovered over
    Then the project's information will be display in the sidebar

  Scenario: Hovering over a project item from project feature
    Given there is a project
    And the "project" has "features"
    When I am on the "projects features" page
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar

  Scenario: Hovering over an item from the features index
    Given there are features
    When I am on "all features"
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar

  Scenario: Hovering over a story item
    Given there are stories
    When I am on "all stories"
    And the first story is hovered over
    Then the story's information will be display in the sidebar

  Scenario: When viewing a project we must be able to hover of its items
    Given there is a project
    Given the "project" has "features"
    When I am on "a project"
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar
    
  Scenario: When viewing a project's feature we must be able to hover of its items
    Given there is a project
    Given the "project" has "features"
    When I am on the "projects features" page
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar
    
  Scenario: When viewing a feature we must be able to hover of its items
    Given there is a feature
    Given the "feature" has "stories"
    When I am on "a feature"
    And the first story is hovered over
    Then the story's information will be display in the sidebar