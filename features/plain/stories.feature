Feature: Stories will be needed to populate our projects features
  In order for a user to populate their features, they will need to be able to create stories and associate these with the desired feature
  As a user
  I want to be able to create stories and associate them with features
		
  Scenario: I should be able to view all stories
    Given there are stories
    When I am on "all stories"
    Then there should be a list of stories
    And each story should have a scenario

  Scenario: As a user I should be able to create a new story
    Given there are features
    When I am on "all features"
    And I select first feature new story link
    And I fill in the story form
    Then submit the form
    And the story information should be saved
    And I should be redirected to the new story
    And a flash message 'Story: this is our stories scenario, was created' should be displayed

  Scenario: As a user I should be able to view all the features stories
    Given there are features
    When I am on "all features"
    When I select first feature
    Then I should see a list of stories
    And each story should have a scenario

  Scenario: As a user I should be able to create a new story via the stories page
    Given there are stories
    When I am on "all stories"
    Then I should be see a link to create a new story

  Scenario: I should be able to edit a story
    Given there is a story
    And I am on "edit story"
    And uncheck a feature it is associated to
    Then submit the form
    And the story should no long store the feature

  Scenario: I should be able to select a pre-existing step, which we can use instead
    Given there is a story
    When I am on "a story"
    And check a pre-existing step
    Then submit the form
    And it should be saved

  Scenario: If a scenario has examples we must be able to see them.
    Given we have a stories with examples
    When I am on "a story"
    Then we should the example should be displayed