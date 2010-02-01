Feature: Feature forms should have client side validations
  In order to improve the performance of the salad
  As a system feature
  I want to allow for validation of the feature forms

  Scenario: The "title" field is required
    Given I can view the features page
    When I click new features
    And we fill in the feature in_order with 'to create the best app'
    And we fill in the feature as_a with 'user'
    And we fill in the feature i_want with 'the best project ever'
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Scenario: The "in_order" field is required
    Given I can view the features page
    When I click new features
    And we fill in the feature title with 'Logging in'
    And we fill in the feature as_a with 'user'
    And we fill in the feature i_want with 'the best project ever'
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Scenario: The "as_a" field is required
    Given I can view the features page
    When I click new features
    And we fill in the feature title with 'Logging in'
    And we fill in the feature in_order with 'to create the best app'
    And we fill in the feature i_want with 'the best project ever'
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Scenario: The "i_want" field is required
    Given I can view the features page
    When I click new features
    And we fill in the feature title with 'Logging in'
    And we fill in the feature in_order with 'to create the best app'
    And we fill in the feature as_a with 'user'
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Scenario: The "title" field should have more than 7 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature title with 'to'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least 7 characters."

  Scenario: The "in_order" field should have more than 7 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature in_order with 'to do'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least 7 characters."

  Scenario: The "as_a" field should have more than 4 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature as_a with 'use'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least 4 characters."

  Scenario: The "i_want" field should have more than 7 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature i_want with 'not'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least 7 characters."