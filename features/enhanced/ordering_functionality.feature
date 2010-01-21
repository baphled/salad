Feature: Order items
    In order to order salad items
    As an user
    I want to be able to sort items into the appropriate order

    Scenario: Ordering a projects features
      Given the project has features
      When I visit the projects features
      And I press order
      Then I should see the order handler
      And I should be able to move the second feature to the first position
      And the items should be reordered