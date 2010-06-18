Feature: Stories will be needed to populate our projects features
  In order for a user to populate their features, they will need to be able to create stories and associate these with the desired feature
  As a user
  I want to be able to create stories and associate them with features
		
  Scenario: I should be able to view all stories
    Given I can view the stories page
    And there are stories
    Then there should be a list of stories
    And each story should have a scenario

  Scenario: As a user I should be able to create a new story
    Given I can view the features page
    And there are features
    When I select first feature new story link
    And we fill in the story scenario with 'this is our stories scenario'
    Then submit the form
    And the story information should be saved
    And I should be redirected to the new story
    And a flash message 'Story: this is our stories scenario, was created' should be displayed

  Scenario: As a user I should be able to view all the features stories
    Given I can view the features page
    And there are features
    When I select first feature
    Then I should see a list of stories
    And each story should have a scenario

  Scenario: As a user I should be able to create a new story via the stories page
    Given I can view the stories page
    And there are stories
    Then I should be see a link to create a new story

  Scenario: I should be able to edit a story
    Given I can view the stories page
    And there are stories
    When I edit the first story
    And uncheck a feature it is associated to
    Then submit the form
    And the story should no long store the feature

  Scenario: I should be able to select a pre-existing step, which we can use instead
    Given there are stories
    When I select first story
    And check a pre-existing step
    Then submit the form
    And it should be saved

  Scenario: If a scenario has examples we must be able to see them.
    Given we have a stories with examples
    When the story is viewed
    Then we should the example should be displayed

  Scenario: A story must start with 'Given' otherwise it does not validate
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'Given we have a new step'
    Then submit the form
    And the step should be saved as 'Given we have a new step'
    And a flash message 'Step: Given we have a new step, was created' should be displayed

  Scenario: A story must start with 'When' otherwise it does not validate
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'When we have a new step'
    Then submit the form
    And the step should be saved as 'When we have a new step'
    And a flash message 'Step: When we have a new step, was created' should be displayed

  Scenario: A story must start with 'Then' otherwise it does not validate
    Given I can view the steps page
    When I click new steps
    And we fill in the step title with 'Then we have a new step'
    Then submit the form
    And the step should be saved as 'Then we have a new step'
    And a flash message 'Step: Then we have a new step, was created' should be displayed