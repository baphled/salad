Feature: All item information should be layed out in a similar way
  In order to give the system a similar feel
  As a user
  I want to see item information in a generic format

  Scenario Outline: All pages should be consistently layed out
    Given there is a <model>
    And the <model>s creation date is not the same as the updated date
    When I am on "<page>"
    Then the "<model>" information header should be displayed
    And the "<property>" should be displayed

  Examples: List of items and their properties
    | model   | page      | property                |
    | project | a project | Title                   |
    | project | a project | Location                |
    | project | a project | Aim                     |
    | project | a project | Creation date           |
    | project | a project | Updated date            |
    | feature | a feature | Title                   |
    | feature | a feature | In order                |
    | feature | a feature | I want                  |
    | feature | a feature | As a                    |
    | feature | a feature | Creation date           |
    | feature | a feature | Updated date            |
    | story   | a story   | Scenario                |
    | step    | a step    | Title                   |

   Scenario Outline: All items should display their associated items information if there are any
    Given there is a <model>
    And the "<model>" has 5 "<associated>"
    When I am on "<page>"
    And the "<property>" should be displayed

   Examples: A list of models that should display associated items information
    | model   | associated  | page      | property                 |
    | project | features    | a project | Total number of Features |
    | project | features    | a project | Last Feature             |
    | feature | stories     | a feature | Total number of Stories  |
    | feature | stories     | a feature | Last Story               |
    | story   | steps       | a story   | Total number of Steps    |
    | story   | steps       | a story   | Last Step                |

  Scenario: Viewing a project features should display the project information in a pre defined layout
    Given there is a project
    And the project has features
    And the projects creation date is not the same as the updated date
    When I am on "projects features"
    Then it should display all the project information

  Scenario: Viewing a features stories should display the features information in a pre defined layout
    Given there is a feature
    Given the "feature" has 5 "stories"
    When I am on "features stories"
    Then it should display all the feature information

  Scenario: Viewing a storys steps should display the storys information in a pre defined layout
    Given there is a story
    And the "story" has 5 "steps"
    Given the story has steps
    When I am on "stories steps"
    Then it should display all the story information

  Scenario Outline: If an items has no associated items we should not display 0 but something more informative
    Given there is a <model> with no <associations>
    When I am on "<page>"
    Then the copy "No <associations> associated" should be displayed
    And "Total number of <postfix>" should not be displayed

  Examples: No associations for a given action
    | page      | model   | associations | postfix  |
    | a project | project | features     | Features |
    | a feature | feature | stories      | Stories  |
    | a story   | story   | steps        | Steps    |
