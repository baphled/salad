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
 | controller | model    | value     | property    | input_type | selector                     | error                                            |
 | features   | feature  |           | title       | input      | li#feature_title_input       | can't be blank                                   |
 | features   | feature  | to        | title       | input      | li#feature_title_input       | Please enter at least 6 characters.              |
 | features   | feature  |           | in_order    | input      | li#feature_title_input       | can't be blank                                   |
 | features   | feature  | to do     | in_order    | input      | li#feature_in_order_input    | Please enter at least 7 characters.              |
 | features   | feature  |           | as_a        | input      | li#feature_title_input       | can't be blank                                   |
 | features   | feature  | use       | as_a        | input      | li#feature_as_a_input        | Please enter at least 4 characters.              |
 | features   | feature  |           | i_want      | input      | li#feature_title_input       | can't be blank                                   |
 | features   | feature  | not       | i_want      | input      | li#feature_i_want_input      | Please enter at least 7 characters.              |
 | projects   | project  |           | title       | input      | li#project_title_input       | can't be blank                                   |
 | projects   | project  | so        | title       | input      | li#project_title_input       | Please enter at least 3 characters.              |
 | projects   | project  |           | aim         | input      | li#project_title_input       | can't be blank                                   |
 | projects   | project  | foo       | aim         | input      | li#project_aim_input         | Please enter at least 6 characters.              |
 | projects   | project  |           | description | input      | li#project_title_input       | can't be blank                                   |
 | projects   | project  | too short | description | input      | li#project_description_input | Please enter at least 12 characters.             |
 | projects   | project  | blah/     | location    | input      | li#project_location_input    | Must be a valid project location on your system. |
 | steps      | step     |           | title       | input      | li#step_title_input          | can't be blank                                   |
 | steps      | step     | foo       | title       | input      | li#step_title_input          | Please enter at least 12 characters.             |
 | stories    | story    | blah      | scenario    | input      | li#story_scenario_input      | Please enter at least 7 characters.              |
 | stories    | story    |           | scenario    | input      | li#story_scenario_input      | can't be blank                                   |
 | parking    | resource |           | name        | input      | li#resource_name_input       | can't be blank                                   |
 | parking    | resource |           | name        | input      | li#resource_name_input       | Please enter at least 3 characters.              |
 | parking    | resource |           | project     | input      | li#resource_project_input    | can't be blank                                   |
 | parking    | resource |           | project     | input      | li#resource_project_input    | Please enter at least 3 characters.              |


  # Relies on fixtures
  Scenario: A project must be unique
    Given I can view the projects page
    When I click new projects
    And we fill in the project title with 'A fixture project'
    And we fill in the project aim with 'A description for our project'
    And we fill in the project description with 'A projects aims'
    Then submit the form
    And the project information should not be saved
    And the error message should be "has already been taken"

  # Relies on fixtures
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

  # Relies on fixtures
  Scenario: If a story is not unique we need to display a error
    Given I can view the stories page
    When I use the "New Story" link
    And we fill in the story scenario with 'my stories 1st scenario'
    Then submit the form
    And the error message should be "has already been taken"

  Scenario: A story invalid if it does not have 'Given' as a prefix
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'we have a new step'
    Then submit the form
    Then the step should be not saved
    And the message 'Title must start with Given, When or Then' should be displayed