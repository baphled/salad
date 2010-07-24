Feature: Hover functionality
    In order to view more information about an item
    As a user
    I want to more information to be display when I hover over an item

  Scenario Outline: Hovering over an item
    Given there is a <model>
    And the <model> has 1 <associated>
    When I am on "<page>"
    And the first <item> is hovered over
    Then the <item>'s information will be display in the sidebar

  Examples:
    | model   | associated | item    | page         |
    | project | features   | feature | a project    |
    | feature | storys     | story   | a feature    |
    | story   | steps      | step    | a story      |


  # @TODO Cover other pages with hover functionality
  Scenario Outline: Hovering over items with associations
    Given there are <models>
    And there is a <model>
    And the <model> has <associated>
    When I am on "<page>"
    And the first <model> is hovered over
    Then the <model>'s information will be display in the sidebar

  Examples: List of pages that have associated items
    | models   | model    | associated | page         |
    | projects | project  | features   | all projects |
    | features | feature  | stories    | all features |
    | stories  | story    | steps      | all stories  |

  Scenario Outline: Hovering over a feature displays its stories
    Given there is a project
    And the project has features
    When I am on "<page>"
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar

  Examples: List of pages that have hover functionality
    | page              |
    | a project         |
    | projects features |
