Feature: Ordering functionality
  In order to order salad items
  As an user
  I want to be able to sort items without having the page refresh

  Scenario Outline: The order button should not be present if there are is only one item
    Given there is a <model>
    And the "<model>" has 1 "<assoc>"
    When I am on the "<page name>" page
    Then it should "does not" have an order button

  Examples: List of pages that use the list layout
    | model   | assoc   | page name         |
    | project | feature | a project         |
    | feature | story   | a feature         |
    | story   | step    | a story           |
    | step    |         | a step            |
    | project | feature | projects features |
    | feature | story   | features stories  |
    | story   | step    | stories steps     |
    | project | feature | all projects      |
    | feature | story   | all features      |
    | story   | step    | all stories       |
    | step    |         | all steps         |

  Scenario Outline: Ordering items
    Given there is a <model>
    And the "<model>" has 5 "<assoc>"
    When I am on the "<page name>" page
    And I press order
    Then I should see the order handler
    And I should be able to move the second item to the first position
    And the items should be reordered

  Examples: List of items than can be reordered
    | model   | assoc     | page name         |
    | project | features  | projects features |
    | feature | stories   | features stories  |
    | story   | steps     | stories steps     |

  Scenario Outline: The ordering button should not be on any of the model index pages
    Given there is a <model>
    And the "<model>" has 5 "<assoc>"
    When I am on the "<page name>" page
    Then it should "<have order button>" have an order button

  Examples: List of pages that use the list layout
    | model   | assoc   | amount |  page name         | have order button |
    | project | feature | 5      | a project         | does              |
    | feature | story   | 5      | a feature         | does              |
    | story   | step    | 5      | a story           | does              |
    | step    |         | 5      | a step            | does not          |
    | project | feature | 5      | projects features | does              |
    | feature | story   | 5      | features stories  | does              |
    | story   | step    | 5      | stories steps     | does              |
    | project | feature | 5      | all projects      | does not          |
    | feature | story   | 5      | all features      | does not          |
    | story   | step    | 5      | all stories       | does not          |
    | step    |         | 5      | all steps         | does not          |
    | project | feature | 1      | a project         | does not          |
    | feature | story   | 1      | a feature         | does not          |
    | story   | step    | 1      | a story           | does not          |
    | project | feature | 1      | projects features | does not          |
    | feature | story   | 1      | features stories  | does not          |
    | story   | step    | 1      | stories steps     | does not          |

  Scenario: Should not be able to order items if there is only one item
    Given the project has one feature
    When I am on the "projects features" page
    Then it should "does not" have an order button