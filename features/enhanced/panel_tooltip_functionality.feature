Feature: When hovering over a panel link we want to display a speech bubble tooltip
  In order to improve the userability of the panel links
  As an user
  I want to be given functionality information when hovering over a panel link

  Scenario: When hovering over the feature's export link displays a tooltip
    Given there is a feature
    When I view the feature
    And I click "span#panel"
    Then there should be a "Export a feature" link
    And I hover over the "export-feature" link
    Then a tooltip should be visible

  Scenario: When hovering over the feature's edit link displays a tooltip
    Given there is a feature
    When I view the feature
    And I click "span#panel"
    Then there should be a "Edit" link
    And I hover over the "edit" link
    Then a tooltip should be visible

  Scenario Outline: When hovering over the feature changes displays a tooltip
    Given we create a feature with a path
    When the feature is viewed
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
     When the feature is viewed
     And I click "span#panel"
     Then the panel icons should be visible
     When I am on "system merge"
     Then the system merge page should be displayed
     When I hover over the "update-feature" link
     Then a tooltip should be visible
     
   Scenario Outline: When hovering over the project panel links displays a tooltip
     Given there is a project
     When the project is viewed
     And I click "span#panel"
     Then there should be a "<link>" link
     And I hover over the "<id>" link
     Then a tooltip should be visible
      
    Examples: List of project panel links that should have tool tips
       | link                                                       | id           |
       | Allows you to import features singularly                   | import       |
       | Allows you to import all project features in one easy step | import-all   |
       | Allows you to edit a projects information                  | edit |
       
  Scenario: When hovering over the step panel links displays a tooltip
    Given there is a step
    When the step is viewed
    And I click "span#panel"
    Then there should be a "Edit the step" link
    And I hover over the "edit" link
    Then a tooltip should be visible
    
  Scenario: When hovering over the story panel links displays a tooltip
    Given there is a story
    When the story is viewed
    And I click "span#panel"
    Then there should be a "Edit the story" link
    And I hover over the "edit" link
    Then a tooltip should be visible