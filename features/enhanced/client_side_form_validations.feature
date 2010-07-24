Feature: Client side form validations
  In order to improve the performance of the salad
  As a user
  I want to be notified of validation issues before the form submits

  Scenario Outline: All new forms that required fields should be validated by client side validations
    When I am on "<page name>"
    And I don't fill in the <model> "<field>"
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Examples: List of fields that are required
    | page name    | model    | field       |
    | new feature  | feature  | title       |
    | new feature  | feature  | in_order    |
    | new feature  | feature  | as_a        |
    | new feature  | feature  | i_want      |
    | new project  | project  | title       |
    | new project  | project  | description |
    | new project  | project  | aim         |
    | new story    | story    | scenario    |
    | new step     | step     | title       |
    | new resource | resource | name        |
    | new resource | resource | project     |

  Scenario Outline: All edit forms that required fields should be validated by client side validations
    Given there is a <model>
    When I am on "<page name>"
    And I don't fill in the <model> "<field>"
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Examples: List of edit forms that should be validated
    | edit feature | feature  | title       |
    | edit feature | feature  | in_order    |
    | edit feature | feature  | as_a        |
    | edit feature | feature  | i_want      |
    | edit project | project  | title       |
    | edit project | project  | description |
    | edit project | project  | aim         |
    | edit story   | story    | scenario    |
    | edit step    | step     | title       |

  Scenario Outline: All fields with character limits should be validated by client side validation
    When I am on "<page name>"
    And I fill in the <model> form <field> with "<value>"
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least <amount> characters."

  Examples: List of fields that have character limits
    | page name    | model    | field       | value     | amount |
    | new feature  | feature  | title       | to        | 7      |
    | new feature  | feature  | in_order    | to do     | 7      |
    | new feature  | feature  | as_a        | use       | 4      |
    | new feature  | feature  | i_want      | not       | 7      |
    | new project  | project  | title       | so        | 3      |
    | new project  | project  | aim         | so        | 6      |
    | new project  | project  | description | too short | 12     |
    | new story    | story    | scenario    | this      | 7      |
    | new resource | resource | name        | fo        | 3      |
    | new resource | resource | project     | fo        | 3      |

  Scenario Outline: All listed models must be unique
    Given there is a <model>
    When I am on "new <model>"
    And I fill in the <model> form with duplicate data
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be a unique <model>."
    
  Examples: List of models that must be unique
    | model   |
    | project |
    | feature |
    | story   |

  Scenario: A client side error is displayed if it does not have 'Given' as a prefix
    When I am on "new step"
    And we fill in the step title with 'we have a new step'
    Then submit the form
    Then the step should be not saved
    And a JS based error message should be displayed
    And the client side error message should be "must start with Given, When or Then"

  Scenario: A user gets a JS error if A projects location must be a valid project location on their system
    When I am on the "new project" page
    And we fill in the project location with '/s'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be a valid project location on your system."
