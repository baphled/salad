Feature: Item listing
  In order to not confuse users without JavaScript enabled
  As a user
  I want to not see the order button when JavaScript is not enabled
  
  Scenario Outline: All listings should not display the order button
    Given there is a <model>
    When I am on "<page name>"
    Then the order button should not be visible
    
  Examples: List of pages that have displays a list of items but does not display the order button
    | model   | page name         |
    | project | a project         |
    | feature | a feature         |
    | story   | a story           |
    | project | projects features |
    | feature | features stories  |
    | story   | stories steps     |