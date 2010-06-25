Feature: We want to us different layout for specific types of actions and areas
  In order to help inform the user that specific actions have different layouts associated to them
  As an user
  I want to see different layouts for specific actions and areas

  Scenario Outline: Viewing the all forms should display the no sidebar layout
    When I view the "<model>" "<action>"
    Then the view "<matcher>" have a sidebar

  Examples: List of actions that have no sidebars in their layout
    | model    | action | matcher    |
    | projects | new    | should not |
    | features | new    | should not |
    | stories  | new    | should not |
    | steps    | new    | should not |
    | steps    | new    | should not |
    | projects |        | should     |
    | features |        | should     |
    | stories  |        | should     |
    | steps    |        | should     |

  Scenario Outline: Viewing specific actions should render specific layouts
    When I view the "<page name>" path
    Then the view "<matcher>" have a sidebar
    
  Examples: List of models to view and their associated actions
    | page name       | matcher    |
    | export feature  | should not |
    | import project  | should not |
    | feature changes | should not |
    | feature merge   | should not |
    | system merge    | should not |
