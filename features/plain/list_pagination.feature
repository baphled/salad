Feature: All lists should have pagination when there are more than 5 items in a list
  In order to keep the size of the lists to a minimum
  As a user
  I want to lists of more than 5 to be paginated

  Scenario Outline: I should see pagination only when there are more than 5 items
    Given there are "<items>"
    And there are <moreorless> than 5 "<items>"
    When I am on "<page name>"
    Then we should not see our pagination

  Examples: All non-associated lists
    | items     |page name    |moreorless |
    | projects  | all projects | less       |
    | features  | all features | less       |
    | stories   | all stories  | less       |
    | steps     | all steps    | less       |