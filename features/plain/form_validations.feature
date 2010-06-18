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

  Examples: Models and their properties
    | controller | model   | value     | property  | input_type  |
    | features   | feature | to        | title     | input       |
    | features   | feature | to do     | in_order  | input       |
    | features   | feature | use       | as_a      | input       |
    | features   | feature | not       | i_want    | input       |