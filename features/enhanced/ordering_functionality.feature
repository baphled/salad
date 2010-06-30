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
      When I view the "<page name>" path
      Then it should "<have order button>"
      
    Examples: List of pages that use the list layout
      | page name         | have order button |
      | a project         | does              |
      | a feature         | does              |
      | a story           | does              |
      | a step            | does not          |
      | projects features | does              |
      | features stories  | does              |
      | stories steps     | does              |
      | all projects      | does not          |
      | all features      | does not          |
      | all stories       | does not          |
      | all steps         | does not          |

    Scenario: Should not be able to order items if there is only one item
      Given the project has one feature
      When I visit the projects features
      Then it should "does not" have an order button
    
    
    