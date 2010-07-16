Feature: Validation of forms
  In order to help the user create valid input
  As an user
  I want to be alert on invalid data input

  Scenario Outline: All validation should have an error class
    When I am on "new <model>"
    And we fill in the <model> <property> with '<value>'
    Then submit the form
    And the "<model>" "<property>" "<input_type>" should have an error class
    And I should see "<error>" within "<selector>"

  Examples: Models and their properties
    | controller | model    | value               | property    | input_type | selector                     | error                                            |
    | features   | feature  |                     | title       | input      | li#feature_title_input       | can't be blank                                   |
    | features   | feature  | to                  | title       | input      | li#feature_title_input       | Please enter at least 6 characters.              |
    | features   | feature  |                     | in_order    | input      | li#feature_title_input       | can't be blank                                   |
    | features   | feature  | to do               | in_order    | input      | li#feature_in_order_input    | Please enter at least 7 characters.              |
    | features   | feature  |                     | as_a        | input      | li#feature_title_input       | can't be blank                                   |
    | features   | feature  | use                 | as_a        | input      | li#feature_as_a_input        | Please enter at least 4 characters.              |
    | features   | feature  |                     | i_want      | input      | li#feature_title_input       | can't be blank                                   |
    | features   | feature  | not                 | i_want      | input      | li#feature_i_want_input      | Please enter at least 7 characters.              |
    | projects   | project  |                     | title       | input      | li#project_title_input       | can't be blank                                   |
    | projects   | project  | so                  | title       | input      | li#project_title_input       | Please enter at least 3 characters.              |
    | projects   | project  |                     | aim         | input      | li#project_title_input       | can't be blank                                   |
    | projects   | project  | foo                 | aim         | input      | li#project_aim_input         | Please enter at least 6 characters.              |
    | projects   | project  |                     | description | input      | li#project_title_input       | can't be blank                                   |
    | projects   | project  | too short           | description | input      | li#project_description_input | Please enter at least 12 characters.             |
    | projects   | project  | blah/               | location    | input      | li#project_location_input    | Must be a valid project location on your system. |
    | steps      | step     |                     | title       | input      | li#step_title_input          | can't be blank                                   |
    | steps      | step     | we have a new step  | title       | input      | li#step_title_input          | must start with Given, When or Then        |
    | steps      | step     | foo                 | title       | input      | li#step_title_input          | Please enter at least 12 characters.             |
    | stories    | story    | blah                | scenario    | input      | li#story_scenario_input      | Please enter at least 7 characters.              |
    | stories    | story    |                     | scenario    | input      | li#story_scenario_input      | can't be blank                                   |
    | parking    | resource |                     | name        | input      | li#resource_name_input       | can't be blank                                   |
    | parking    | resource |                     | name        | input      | li#resource_name_input       | Please enter at least 3 characters.              |
    | parking    | resource |                     | project     | input      | li#resource_project_input    | can't be blank                                   |
    | parking    | resource |                     | project     | input      | li#resource_project_input    | Please enter at least 3 characters.              |

  # Relies on fixtures
  Scenario Outline: There should not be any duplicate entries
    When I am on "new <model>" page
    And I fill in the <model> form with duplicate data
    Then submit the form
    And the <model> information should not be saved
    And the error message should be "has already been taken"

  Examples: List of models that must be unique
    | model   |
    | project |
    | feature |
    | story   |