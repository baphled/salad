Feature: Item listing
  In order to not confuse users without javascript enabled
  As a user
  I want to not see the order button
  
  Scenario Outline: All listings should not display the order button
    When I view the "<page name>" path
    Then the order button should not be visible
    
  Examples: List of pages that have sortable functionality but do not display the order button
    | page name         |
    | a project         |
    | a feature         |
    | a story           |
    | projects features |
    | features stories  |
    | stories steps     |
