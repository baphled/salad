Feature: We need to be able to easily navigate the website
  In order to help users experience the whole site
  As a user
  I want to be able to easily move around the site using the sites navigation
  
  Scenario Outline: We need to make sure that all pages have navigation
    Given I can view the <page> page
    Then the navigation should be displayed
  
  Examples: Basic pages that we want to have navigation highlighting
  | page     |
  | projects |
  | features |
  | stories  |
  | steps    |
  | parking  |

  Scenario Outline: When navigating to a page we want to make sure the menu item is actually selected
    Given I can view the <page> page
    Then the navigation should be displayed
    And the "<menu_item>" will be selected
  
  Examples: More advanced pages which need to have navigation highlighting
  | page       | menu_item   |
  | projects   | projects    |
  | features   | features    |
  | stories    | stories     |
  | steps      | steps       |
  | parking    | parking     |
  | projects/1 | projects    |
  | features/1 | features    |
  | stories/1  | stories     |
  | steps/1    | steps       |