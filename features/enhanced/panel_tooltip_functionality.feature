Feature: Panel tooltip functionality
  In order to improve the userability of the panel links
  As an user
  I want to be given functionality information when hovering over a panel link

  # @TODO Add all missing tooltips if any
  Scenario: When hovering over the feature's export link displays a tooltip
    Given there is a feature
    And the "feature" has 5 "stories"
    When I am on "a feature"
    And I click "span#panel"
    Then there should be a "Export a feature" link
    And I hover over the "export-feature" link
    Then a tooltip should be visible

  Scenario Outline: Hovering over an item panels link should display a tootip
    Given there is a step
    When I am on "a step"
    And I click "span#panel"
    Then there should be a "Edit the step" link
    And I hover over the "edit" link
    Then a tooltip should be visible

  Examples: List of page that should have edit tooltips
    | model   | page      |
    | project | a project |
    | feature | a feature |
    | story   | a story   |
    | step    | a step    |

  Scenario Outline: When hovering over the feature changes displays a tooltip
    Given we create a feature with a path
    When I am on "a feature"
    And I click "span#panel"
    Then there should be a "<link>" link
    And I hover over the "<id>" link
    Then a tooltip should be visible

  Examples: List of feature panel links that should have tool tips
     | link                                                                   | id            |
     | Check the difference between the systems & your applications features  | view-changes  |
     | Merge a systems changes with the feature                               | merge-changes |
     | Merge a features changes with the system                               | merge-system  |
     | Patch a feature with the systems changes                               | patch-changes |
     
   Scenario: When hovering over the feature panel links displays a tooltip
     Given we create a feature with a path
     When I am on "a feature"
     And I click "span#panel"
     Then the panel icons should be visible
     When I am on "system merge"
     Then the system merge page should be displayed
     When I hover over the "update-feature" link
     Then a tooltip should be visible
     
   Scenario Outline: When hovering over the project panel links displays a tooltip
     Given there is a project
     When I am on "a project"
     And I click "span#panel"
     Then there should be a "<link>" link
     And I hover over the "<id>" link
     Then a tooltip should be visible
      
    Examples: List of project panel links that should have tool tips
       | link                                                       | id           |
       | Allows you to import features singularly                   | import       |
       | Allows you to import all project features in one easy step | import-all   |
       | Allows you to edit a projects information                  | edit         |
