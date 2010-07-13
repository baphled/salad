Feature: Item listing
  In order to not confuse users without javascript enabled
  As a user
  I want to not see the order button
  
  Scenario Outline: All listings should not display the order button
    Given there is a <model>
    When I view the "<page name>" path
    Then the order button should not be visible
    
  Examples: List of pages that have sortable functionality but do not display the order button
    | model   | page name         |
    | project | a project         |
    | feature | a feature         |
    | story   | a story           |
    | project | projects features |
    | feature | features stories  |
    | story   | stories steps     |