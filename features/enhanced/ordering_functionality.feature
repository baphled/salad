Feature: Order items
    In order to order salad items
    As an user
    I want to be able to sort items into the appropriate order

    Scenario Outline: Ordering items
      Given the <model> has <assoc>
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
      When I am on the "<page name>" page
      Then it should "<have order button>" have an order button
      
    Examples: List of pages that use the list layout
      | model   | page name         | have order button |
      | project | a project         | does              |
      | feature | a feature         | does              |
      | story   | a story           | does              |
      | step    | a step            | does not          |
      | project | projects features | does              |
      | feature | features stories  | does              |
      | story   | stories steps     | does              |
      | project | all projects      | does not          |
      | feature | all features      | does not          |
      | story   | all stories       | does not          |
      | step    | all steps         | does not          |

    Scenario: Should not be able to order items if there is only one item
      Given the project has one feature
      When I am on the "projects features" page
      Then it should "does not" have an order button