Feature: All lists should have pagination functionality if there are more than 5 items
    In order to keep the size of the lists to a minimum
    As a developer
    I want to be able paginate our lists
    
    Scenario Outline: All lists with less than 5 items should have pagination
      Given there are "<items>"
      And there are <moreorless> than 5 "<items>"
      When I am on "<page name>"
      Then we should not see our pagination

    Examples: All non-associated lists
      | items     |page name    |moreorless |
      | projects  | all projects |less       |
      | features  | all features |less       |
      | stories   | all stories  | less       |
      | steps     |all steps    | less       |