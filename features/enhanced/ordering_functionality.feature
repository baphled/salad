Feature: Order items
    In order to order salad items
    As an user
    I want to be able to sort items into the appropriate order

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
      | model   | assoc   | page name         | have order button |
      | project | feature | a project         | does              |
      | feature | story   | a feature         | does              |
      | story   | step    | a story           | does              |
      | step    |         | a step            | does not          |
      | project | feature | projects features | does              |
      | feature | story   | features stories  | does              |
      | story   | step    | stories steps     | does              |
      | project | feature | all projects      | does not          |
      | feature | story   | all features      | does not          |
      | story   | step    | all stories       | does not          |
      | step    |         | all steps         | does not          |

    Scenario: Should not be able to order items if there is only one item
      Given the project has one feature
      When I am on the "projects features" page
      Then it should "does not" have an order button