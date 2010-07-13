Feature: Order items
    In order to order salad items
    As an user
    I want to be able to sort items into the appropriate order

    Scenario: Ordering a projects features
      Given the project has features
      When I visit the projects features
      And I press order
      Then I should see the order handler
      And I should be able to move the second item to the first position
      And the items should be reordered

    Scenario: Ordering a features stories
      Given the feature has stories
      When I visit the features stories
      And I press order
      Then I should see the order handler
      And I should be able to move the second item to the first position
      And the items should be reordered

    Scenario: Ordering a storys steps
      Given the story has steps
      When I visit the stories steps
      And I press order
      Then I should see the order handler
      And I should be able to move the second item to the first position
      And the items should be reordered
      
    Scenario Outline: The ordering button should not be on any of the model index pages
      Given there is a <model>
      When I view the "<page name>" path
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
      When I visit the projects features
      Then it should "does not" have an order button
    
    
    