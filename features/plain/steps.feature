Feature: Steps
  In order to associate steps with stories, we need to be able to create steps and link them
  As a user
  I want to be able to create new steps which I can associate with stories

  Scenario: I must be able to create a new step
    When I am on "new step"
    Then the new step form should be displayed

  # @TODO Move to a notice feature file
  Scenario: I should be able to successfully create a new step
    When I am on "new step"
    Then the new step form should be displayed
    When I fill in the step form
    Then submit the form
    And a flash message 'was created' should be displayed

  Scenario: I should not be able to create a new step if it is not unique
    When I am on "new step"
    Then the new step form should be displayed
    When I fill in the step form
    Then submit the form
    When I am on "new step"
    Then the new step form should be displayed
    When we fill in the step title with 'Given we have a new step'
    Then submit the form
    And the step should be not saved

  Scenario: I should be able to associate a step with a story
    Given there is a story with the "scenario" "my first story"
    When I am on "new step"
    Then the new step form should be displayed
    When I fill in the step form
    And I check 'my first story'
    Then submit the form

  Scenario: I should be able to view the stories a step is linked to
    Given there is a story
    And there is a step
    And the "story" has 5 "steps"
    When I am on "a step"
    Then I should see check boxes for all steps it can be linked to

  # @TODO Move to a notice feature file
  Scenario Outline: A step must start with a given prefix
    Given I am on "new step"
    When we fill in the step title with '<title>'
    Then submit the form
    And the step should be saved as '<title>'
    And a flash message 'Step: <title>, was created' should be displayed

  Examples: List of valid step prefixes
    | title                    |
    | Given we have a new step |
    | When we have a new step  |
    | Then we have a new step  |