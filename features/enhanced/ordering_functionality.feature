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