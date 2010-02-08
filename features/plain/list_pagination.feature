Feature: All lists should have pagination functionality if there are more than 5 items
    In order to keep the size of the lists to a minimum
    As a developer
    I want to be able paginate our lists

    Scenario Outline: All lists with less than 5 items should have pagination
      Given there is a "<items>"
      And there are less than 5 "<items>"
      When I visit the "<items>"
      Then we should not see our pagination

    Scenarios: All non-associated lists
      |items    |
      |projects |
      |features |
      |stories  |
      |steps    |

    Scenario Outline: All lists with more than 5 items should have pagination
      Given there is a "<items>"
      When I visit the "<items>"
      And "<items>" has more than 1 page
      Then we should see our pagination

    Scenarios: All non-associated lists
      |items    |
      |projects |
      |features |
      |stories  |
      |steps    |

    Scenario Outline: All association lists with more than 5 items should have pagination
      Given there is a "<items>"
      And the "<items>" has "<associations>"
      When I visit the "<items>" "<associations>"
      And the "<associations>" page is loaded
      Then we should see our pagination

   Scenarios: All lists with associations
      |items    |associations |
      |projects |features     |
      |features |stories      |
      |stories  |steps        |