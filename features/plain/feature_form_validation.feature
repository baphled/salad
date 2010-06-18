Feature: Feature forms should have client side validations
  In order to improve the performance of the salad
  As a system feature
  I want to allow for validation of the feature forms
  
  Scenario Outline: Feature fields that need validation should display the appropriate error message and error class
    Given I can view the features page
    When I click new features
    And we fill in the feature <property> with '<value>'
    Then submit the form
    And I should see "Please enter at least <number> characters." within "<selector>"
    And the "<model>" "<property>" "<input_type>" should have an error class

  Examples: Form fields and their error messages
    | model   | property  | value     | number  | selector                  | input_type  |
    | feature | title     | to        | 6       | li#feature_title_input    | input       |
    | feature | in_order  | to do     | 7       | li#feature_in_order_input | input       |
    | feature | as_a      | use       | 4       | li#feature_as_a_input     | input       |
    | feature | i_want    | not       | 7       | li#feature_i_want_input   | input       |

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