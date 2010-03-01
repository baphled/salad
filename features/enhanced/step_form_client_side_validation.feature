Feature: Step needs client side validations
  In order to help validate a step, we need to implement some basic validation functionality
  As a system feature
  I want to be able to do basic validation oon a step

  Scenario: Need to display an client side error if there a title is not present
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Scenario: A client side error is displayed if the step title is under the minium requirements
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed
    When we fill in the step title with 'Given'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least 12 characters."
    
  Scenario: A client side error is displayed if it does not have 'Given' as a prefix
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'we have a new step'
    Then submit the form
    Then the step should be not saved
    And a JS based error message should be displayed
    And the client side error message should be "must start with Given, When or Then"

  Scenario: A step should be successfully save if the frontend and backend validation passes
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'Given we have a new step'
    Then submit the form
    And the form should be hidden