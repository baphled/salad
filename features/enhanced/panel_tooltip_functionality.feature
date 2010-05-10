Feature: When hovering over a panel link we want to display a speech bubble tooltip
  In order to improve the userability of the panel links
  As an user
  I want to be given functionality information when hovering over a panel link

  Scenario: When hovering over the feature's export link displays a tooltip
    Given there is a feature
    When I view the feature
    Then there should be a "Export feature" link
    And I hover over the "export-feature" link
    Then a tooltip should be visible

  Scenario: When hovering over the feature's edit link displays a tooltip
    Given there is a feature
    When I view the feature
    Then there should be a "Edit" link
    And I hover over the "edit" link
    Then a tooltip should be visible

  Scenario Outline: When hovering over the feature changes displays a tooltip
    Given we create a feature with a path
    When the feature is viewed
    Then there should be a "<link>" link
    And I hover over the "<id>" link
    Then a tooltip should be visible

  Examples: List of feature panel links that should have tool tips
     | link          | id            |
     | view changes  | view-changes  |
     | merge changes | merge-changes |
     | merge system  | merge-system  |
     | patch changes | patch-changes |
     
   Scenario: When hovering over the feature panel links displays a tooltip
     Given we create a feature with a path
     When the feature is viewed
     When we click on the "Merge system" link
     Then there should be a "Update" link
     And I hover over the "update" link
     Then a tooltip should be visible
     
   Scenario Outline: When hovering over the project panel links displays a tooltip
      Given there is a project
      When the project is viewed
      Then there should be a "Import" link
      And I hover over the "import" link
      Then a tooltip should be visible
      
    Examples: List of project panel links that should have tool tips
       | link         | id           |
       | Import       | import       |
       | Import all   | import-all   |
       | Edit project | edit-project |
       
  Scenario: When hovering over the step panel links displays a tooltip
    Given there is a step
    When the step is viewed
    Then there should be a "Edit step" link
    And I hover over the "edit-step" link
    Then a tooltip should be visible