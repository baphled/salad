Feature: Feature forms should have client side validations
  In order to improve the performance of the salad
  As a system feature
  I want to allow for validation of the feature forms

  Scenario Outline: All validation should have an error class
    Given I can view the features page
    When I click new features
    And we fill in the feature title with '<value>'
    Then submit the form
    And the "<model>" "<property>" "<input_type>" should have an error class

  Examples: Models and their properties
    | model   | value     | property  | input_type  |
    | feature | to        | title     | input       |
    | feature | to do     | in_order  | input       |
    | feature | use       | as_a      | input       |
    | feature | not       | i_want    | input       |

  Scenario: The "title" field should have more than 6 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature title with 'to'
    Then submit the form
    And I should see "Please enter at least 6 characters." within "li#feature_title_input"

  Scenario: The "in_order" field should have more than 7 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature in_order with 'to do'
    Then submit the form
    And I should see "Please enter at least 7 characters." within "li#feature_in_order_input"

  Scenario: The "as_a" field should have more than 4 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature as_a with 'use'
    Then submit the form
    And I should see "Please enter at least 4 characters." within "li#feature_as_a_input"

  Scenario: The "i_want" field should have more than 7 characters
    Given I can view the features page
    When I click new features
    And we fill in the feature i_want with 'not'
    Then submit the form
    And I should see "Please enter at least 7 characters." within "li#feature_i_want_input"

  Scenario: A feature must be unique
    Given I can view the features page
    When I click new features
    And there are features
    And we fill in the feature title with 'my first feature'
    And we fill in the feature in_order with 'to create an project'
    And we fill in the feature as_a with 'developer'
    And we fill in the feature i_want with 'to have the skills'
    Then submit the form
    And the feature information should be not saved
    And the error message should be "has already been taken"