Feature: Stories have steps, which help to define what the action taken within a step
  In order to associate steps with stories, we need to be able to create steps and link them to stories
  As a user
  I want to be able to create new steps which I can associate with stories

  Scenario: A user must be able to create a new step
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed

  Scenario: A user should be able to successfully create a new step
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed
    When I fill in the step form
    Then submit the form
    And the step should be saved as 'Given we have a new step'
    And a flash message 'Step: Given we have a new step, was created' should be displayed

  Scenario: A user should not be able to create a new step if it is not unique
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed
    When I fill in the step form
    Then submit the form
    When I click new steps
    Then the new step form should be displayed
    When we fill in the step title with 'Given we have a new step'
    Then submit the form
    And the step should be not saved

  Scenario: A user should be able to associate a step with a story
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed
    When I fill in the step form
    And I check 'my first story'
    Then submit the form

  Scenario: A user should be able to create a new step via a story
    Given I can view the stories page
    And there are stories
    When I choose 'New Step' link
    When I fill in the step form
    Then submit the form
    And the step should be saved as 'Given we have a new step'
    And a flash message 'Step: Given we have a new step, was created' should be displayed

  Scenario: A user should be able to view the stories a step is linked to
    When I visit the first step
    Then I should see check boxes for all steps it can be linked to