Feature: All forms should have client side validations
  In order to improve the performance of the salad
  As the system
  I want to valdation to be done on the client side

  Scenario Outline: All required fields should be validated by client side validations
    Given I can view the <model> page
    When I click new <model>
    And I don't fill in the <model> "<field>"
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Examples: List of fields that are required
    | model   | field        |
    | features | title       |
    | features | in_order    |
    | features | as_a        |
    | features | i_want      |
    | projects | title       |
    | projects | description |
    | projects | aim         |

  Scenario Outline: All fields with character limits should be validated by client side validation
    Given I can view the <model> page
    When I click new <model>
    And I fill in the <model> form <field> with "<value>"
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least <amount> characters."

  Examples: List of fields that have character limits
    | model    | field       | value     | amount |
    | features | title       | to        | 7      |
    | features | in_order    | to do     | 7      |
    | features | as_a        | use       | 4      |
    | features | i_want      | not       | 7      |
    | projects | title       | so        | 3      |
    | projects | aim         | sommit    | 6      |
    | projects | description | too short | 12     |

  Scenario: A feature must be unique
    Given I can view the features page
    And the feature already exists
    When I click new features
    And there are features
    And we fill in the feature title with 'my first feature'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be a unique feature."