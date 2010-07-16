Feature: We want to us different layout for specific types of actions and areas
  In order to help inform the user that specific actions have different layouts associated to them
  As an user
  I want to see different layouts for specific actions and areas

  Scenario Outline: Viewing specific actions should render specific layouts
    Given there is a <model>
    When I am on "<page name>"
    Then the view "<matcher>" have a sidebar
    
  Examples: List of models to view and their associated actions
    | model   | page name       | matcher    |
    | project | new project     | should not |
    | feature | new feature     | should not |
    | story   | new story       | should not |
    | step    | new step        | should not |
    | project | a project       | should     |
    | feature | a feature       | should     |
    | story   | a story         | should     |
    | step    | a step          | should     |
    | project | import project  | should not |
    | feature | export feature  | should not |
    | feature | feature changes | should not |
    | feature | feature merge   | should not |
    | feature | system merge    | should not |
