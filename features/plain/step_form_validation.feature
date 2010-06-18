Feature: Step needs basic validations
  In order to help validate a step, we need to implement some basic validation functionality
  As a system feature
  I want to be able to do basic validation oon a step

  Scenario: A step need to be a minimum of 12 characters
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed
    When we fill in the step title with 'Given'
    Then submit the form
    And the error message should be "Please enter at least 12 characters."
    
  Scenario: A story invalid if it does not have 'Given' as a prefix
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'we have a new step'
    Then submit the form
    Then the step should be not saved
    And the message 'Title must start with Given, When or Then' should be displayed

  Scenario: A story must start with 'Given' otherwise it does not validate
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'Given we have a new step'
    Then submit the form
    And the step should be saved as 'Given we have a new step'
    And a flash message 'Step: Given we have a new step, was created' should be displayed

  Scenario: A story invalid if it does not have 'When' as a prefix
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'we have a new step'
    Then submit the form
    Then the step should be not saved
    And the message 'Title must start with Given, When or Then' should be displayed

  Scenario: A story must start with 'When' otherwise it does not validate
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'When we have a new step'
    Then submit the form
    And the step should be saved as 'When we have a new step'
    And a flash message 'Step: When we have a new step, was created' should be displayed

  Scenario: A story invalid if it does not have 'Then' as a prefix
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'we have a new step'
    Then submit the form
    Then the step should be not saved
    And the message 'Title must start with Given, When or Then' should be displayed

  Scenario: A story must start with 'Then' otherwise it does not validate
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'Then we have a new step'
    Then submit the form
    And the step should be saved as 'Then we have a new step'
    And a flash message 'Step: Then we have a new step, was created' should be displayed