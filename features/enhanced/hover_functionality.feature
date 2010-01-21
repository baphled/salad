Feature: Hovering over a project item
    In order to view more information when hovering over an item
    As a user
    I want to be able to hover over the item, which in turn displays more information

  Scenario: Hovering over a project item from the projects index
    Given there are projects
    And I visit the projects index page
    When the project page is loaded
    And the first project is hovered over
    Then the project's information will be display in the sidebar

  Scenario: Hovering over a project item from project feature
    Given the project has features
    When I visit the projects features
    And the feature page is loaded
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar

  Scenario: Hovering over an item from the features index
    Given there are features
    And I can view the features page
    When the feature page is loaded
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar

  Scenario: Hovering over a story item
    Given there are stories
    And I can view the stories page
    When the story page is loaded
    And the first story is hovered over
    Then the story's information will be display in the sidebar

  Scenario: When viewing a project we must be able to hover of its items
    Given the project has features
    And the project is viewed
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar
    
  Scenario: When viewing a project's feature we must be able to hover of its items
    Given the project has features
    When I visit the projects features
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar
    
  Scenario: When viewing a feature we must be able to hover of its items
    Given the feature has stories
    And the feature is viewed
    When the story page is loaded
    And the first story is hovered over
    Then the story's information will be display in the sidebar