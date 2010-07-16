Feature: We need to be able to easily navigate the website
  In order to help users experience the whole site
  As a user
  I want to be able to easily move around the site using the sites navigation
  
  Scenario Outline: We need to make sure that all pages have navigation
    When I am on "<page name>"
    Then the navigation should be displayed
  
  Examples: Basic pages that we want to have navigation highlighting
    | page name     |
    | all projects  |
    | all features  |
    | all stories   |
    | all steps     |
    | parking index |

  Scenario Outline: When navigating to a page we want to make sure the menu item is actually selected
    Given there <model>
    When I am on "<page>"
    Then the navigation should be displayed
    And the "<menu_item>" will be selected
    And the navigation should be displayed
    
  Examples: More advanced pages which need to have navigation highlighting
    | model             | page           | menu_item   |
    | are projects      | all projects   | projects    |
    | are features      | all features   | features    |
    | are stories       | all stories    | stories     |
    | are steps         | all steps      | steps       |
    | are resources     | parking index  | parking     |
    | is a project      | a project      | projects    |
    | is a feature      | a feature      | features    |
    | is a story        | a story        | stories     |
    | is a step         | a step         | steps       |