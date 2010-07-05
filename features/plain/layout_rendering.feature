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
    Given there is a <model>
    When I view the "<page name>" path
    Then the view "<matcher>" have a sidebar
    
  Examples: List of models to view and their associated actions
    | model   | page name       | matcher    |
    | feature | export feature  | should not |
    | project | import project  | should not |
    | feature | feature changes | should not |
    | feature | feature merge   | should not |
    | feature | system merge    | should not |
