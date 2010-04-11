Feature: A user should be able to create a scenario example
  In order to help users create examples via Salad
  As a user
  I want to be able to create an example

  Scenario Outline: I should be able to create an example
    Given I visit the new examples action
    When I create a title
    And I select "<action>" actions
    And I select the "<row>" rows
    And click submit
    Then I should be sent to table
    And the table should have "<row>" rows
    And then the flash message "Created example" "<message-type>" displayed
    
  Examples: Validation of examples
    |action|row|message-type|
    |2     |3  |should be   |
    
  Scenario: When editing a scenario outline, we should be able to create an example for it
    Given there is a scenario outline
    When I edit the scearnio
    Then I should see a create an example link

  Scenario: The number of actions are determined by the number of unique actions in the scenario outline
    Given there is a scenario outline
    And the scenario outline has 4 unique actions
    When I edit the scearnio
    And I click the "create example" link
    Then there should be a table with 4 columns

  Scenario: I should be able to determine how many rows an example needs
    Given there is a scenario outline
    And the scenario outline has 4 unique actions
    When I edit the scearnio
    And select 4 rows
    And I click the "create example" link
    Then there should be 4 rows in the example table

