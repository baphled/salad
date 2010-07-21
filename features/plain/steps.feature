Feature: Stories have steps, which help to define what the action taken within a step
  In order to associate steps with stories, we need to be able to create steps and link them to stories
  As a user
  I want to be able to create new steps which I can associate with stories

  Scenario: A user must be able to create a new step
    When I am on "new step"
    Then the new step form should be displayed

  Scenario: A user should be able to successfully create a new step
    When I am on "new step"
    Then the new step form should be displayed
    When I fill in the step form
    Then submit the form
    And a flash message 'was created' should be displayed

  Scenario: A user should not be able to create a new step if it is not unique
    When I am on "new step"
    Then the new step form should be displayed
    When I fill in the step form
    Then submit the form
    When I am on "new step"
    Then the new step form should be displayed
    When we fill in the step title with 'Given we have a new step'
    Then submit the form
    And the step should be not saved

  Scenario: A user should be able to associate a step with a story
    Given there is a story with the "scenario" "my first story"
    When I am on "new step"
    Then the new step form should be displayed
    When I fill in the step form
    And I check 'my first story'
    Then submit the form

  Scenario: A user should be able to create a new step via a story
    Given there is a story
    When I am on "a story"
    And there are stories
    When I choose 'New Step' link
    When I fill in the step form
    Then submit the form
    And a flash message ', was created' should be displayed

  Scenario: A user should be able to view the stories a step is linked to
    Given there is a story
    And there is a step
    And the "story" has 5 "steps"
    When I am on "a step"
    Then I should see check boxes for all steps it can be linked to


  # @TODO Move to the form validation faeture, may well be duplicate scenarios
  Scenario: A step must start with 'Given' otherwise it does not validate
    When I am on "new step"
    And we fill in the step title with 'Given we have a new step'
    Then submit the form
    And the step should be saved as 'Given we have a new step'
    And a flash message 'Step: Given we have a new step, was created' should be displayed

  # @TODO Move to the form validation faeture, may well be duplicate scenarios
  Scenario: A step must start with 'When' otherwise it does not validate
    When I am on "new step"
    And we fill in the step title with 'When we have a new step'
    Then submit the form
    And the step should be saved as 'When we have a new step'
    And a flash message 'Step: When we have a new step, was created' should be displayed

  # @TODO Move to the form validation faeture, may well be duplicate scenarios
  Scenario: A step must start with 'Then' otherwise it does not validate
    When I am on "new step"
    And we fill in the step title with 'Then we have a new step'
    Then submit the form
    And the step should be saved as 'Then we have a new step'
    And a flash message 'Step: Then we have a new step, was created' should be displayed