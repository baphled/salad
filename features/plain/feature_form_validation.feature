Feature: Feature forms should have client side validations
    # Main goal of this project
  In order to improve the performance of the salad
  As the system
  I want to allow for client side validation of the feature forms

  Scenario: The "title" field should have more than 6 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature title with 'to'
    Then submit the form
    And the "feature" "title" "input" should have an error class

  Scenario: The "in_order" field should have more than 7 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature in_order with 'to do'
    Then submit the form
    And the "feature" "in_order" "input" should have an error class

  Scenario: The "as_a" field should have more than 4 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature as_a with 'use'
    Then submit the form
    And the "feature" "as_a" "input" should have an error class

  Scenario: The "i_want" field should have more than 7 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature i_want with 'not'
    Then submit the form
    And the "feature" "i_want" "input" should have an error class