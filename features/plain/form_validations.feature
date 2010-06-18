#
# inspired by Ryan Bates screencast
#
/*
* I can comment this way
*/
# and this way
// and this way
Feature: Validation of forms
  # Main goal of this project
  In order to help the user create valid input
  As an user
  I want to be alert on invalid data input

  Scenario Outline: All validation should have an error class
    Given I can view the <controller> page
    When I click new <controller>
    And we fill in the <model> <property> with '<value>'
    Then submit the form
    And the "<model>" "<property>" "<input_type>" should have an error class
    And I should see "<error>" within "<selector>"

  Examples: Models and their properties
    | controller | model   | value     | property    | input_type  | selector                     | error                                             |
    | features   | feature | to        | title       | input       | li#feature_title_input       | Please enter at least 6 characters.               |
    | features   | feature | to do     | in_order    | input       | li#feature_in_order_input    | Please enter at least 7 characters.               |
    | features   | feature | use       | as_a        | input       | li#feature_as_a_input        | Please enter at least 4 characters.               |
    | features   | feature | not       | i_want      | input       | li#feature_i_want_input      | Please enter at least 7 characters.               |
    | projects   | project | so        | title       | input       | li#project_title_input       | Please enter at least 3 characters.               |
    | projects   | project | foo       | aim         | input       | li#project_aim_input         | Please enter at least 6 characters.               |
    | projects   | project | too short | description | input       | li#project_description_input | Please enter at least 12 characters.              |
    | projects   | project | blah/     | location    | input       | li#project_location_input    | Must be a valid project location on your system.  |
    | steps      | step    |           | title       | input       | li#step_title_input          | Please enter at least 12 characters.              |
    | stories    | story   | blah      | scenario    | input       | li#story_scenario_input      | Please enter at least 7 characters.              |