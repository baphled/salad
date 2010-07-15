Feature: Feature forms should have client side validations
  In order to improve the performance of the salad
  As a system feature
  I want to allow for validation of the feature forms

  Scenario Outline: All required fields should be validated by client side validations
    Given I can view the features page
    When I click new features
    And I don't fill in the feature "<field>"
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Examples: List of fields that are required
    | field    |
    | title    |
    | in_order |
    | as_a     |
    | i_want   |

  Scenario Outline: All fields with character limits should be validated by client side validation
    Given I can view the features page
    When I click new features
    And we fill in the feature <field> with '<value>'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least <amount> characters."

  Examples: List of fields that have character limits
    | field | value | amount |
    | title    | to    | 7      |
    | in_order | to do | 7      |
    | as_a     | use   | 4      |
    | i_want   | not   | 7      |
    
  Scenario: A feature must be unique
    Given I can view the features page
    And the feature already exists
    When I click new features
    And there are features
    And we fill in the feature title with 'my first feature'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be a unique feature."