Feature: Form validations
  In order to help the user create valid input
  As an user
  I want to be alert on invalid data input

  Scenario Outline: All validation should have an error class
    When I am on "new <model>"
    And we fill in the <model> <property> with '<value>'
    Then submit the form
    And the "<model>" "<property>" "<input_type>" should have an error class
    And I should see "<error>" within "li#<selector id>"

  Examples: Models and their properties
    | controller | model    | value               | property    | input_type | selector id               | error                                            |
    | features   | feature  |                     | title       | input      | feature_title_input       | can't be blank                                   |
    | features   | feature  | to                  | title       | input      | feature_title_input       | Please enter at least 6 characters.              |
    | features   | feature  |                     | in_order    | input      | feature_title_input       | can't be blank                                   |
    | features   | feature  | to do               | in_order    | input      | feature_in_order_input    | Please enter at least 7 characters.              |
    | features   | feature  |                     | as_a        | input      | feature_title_input       | can't be blank                                   |
    | features   | feature  | use                 | as_a        | input      | feature_as_a_input        | Please enter at least 4 characters.              |
    | features   | feature  |                     | i_want      | input      | feature_title_input       | can't be blank                                   |
    | features   | feature  | not                 | i_want      | input      | feature_i_want_input      | Please enter at least 7 characters.              |
    | projects   | project  |                     | title       | input      | project_title_input       | can't be blank                                   |
    | projects   | project  | so                  | title       | input      | project_title_input       | Please enter at least 3 characters.              |
    | projects   | project  |                     | aim         | input      | project_title_input       | can't be blank                                   |
    | projects   | project  | foo                 | aim         | input      | project_aim_input         | Please enter at least 6 characters.              |
    | projects   | project  |                     | description | input      | project_title_input       | can't be blank                                   |
    | projects   | project  | too short           | description | input      | project_description_input | Please enter at least 12 characters.             |
    | projects   | project  | blah/               | location    | input      | project_location_input    | Must be a valid project location on your system. |
    | steps      | step     |                     | title       | input      | step_title_input          | can't be blank                                   |
    | steps      | step     | we have a new step  | title       | input      | step_title_input          | must start with Given, When or Then              |
    | steps      | step     | foo                 | title       | input      | step_title_input          | Please enter at least 12 characters.             |
    | stories    | story    | blah                | scenario    | input      | story_scenario_input      | Please enter at least 7 characters.              |
    | stories    | story    |                     | scenario    | input      | story_scenario_input      | can't be blank                                   |
    | parking    | resource |                     | name        | input      | resource_name_input       | can't be blank                                   |
    | parking    | resource |                     | name        | input      | resource_name_input       | Please enter at least 3 characters.              |
    | parking    | resource |                     | project     | input      | resource_project_input    | can't be blank                                   |
    | parking    | resource |                     | project     | input      | resource_project_input    | Please enter at least 3 characters.              |

  # @TODO Move all scenarios relating to valid form input

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

  Scenario: The Lighthouse account name must be valid
    When I am on "parking new"
    And I fill in "resource_name" with "foo"
    And I fill in "resource_project" with "50164"
    And submit the form
    Then there a error "Name must be a valid LightHouse project name" should be displayed

  Scenario: The Lighthouse project number must be valid
    When I am on "parking new"
    And I fill in "resource_name" with "baphled"
    And I fill in "resource_project" with "23"
    And submit the form
    Then there a error "Project must be a valid LightHouse project" should be displayed