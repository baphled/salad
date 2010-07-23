Feature: Stories
  In order to make feature complete
  As a user
  I want to be able to create stories and associate to features
		
  Scenario: I should be able to view all stories
    Given there are stories
    When I am on "all stories"
    Then there should be a list of stories
    And each story should have a scenario

  Scenario: I can create a new story from a feature list
    Given there are features
    When I am on "all features"
    And I select first feature new story link
    And I fill in the story form
    Then submit the form
    And I should be redirected to the new story
    And a flash message 'was created' should be displayed

  Scenario: I should be able to view all the features stories
    Given there is a feature
    And the "feature" has 5 "stories"
    When I am on "a feature"
    Then I should see a list of stories
    And each story should have a scenario

  Scenario: I should be able to create a new story via the stories page
    Given there are stories
    When I am on "all stories"
    Then I should be see a link to create a new story

  Scenario: I should be able to select a pre-existing step, which we can use instead
    Given there is a story
    And there are steps
    When I am on "a story"
    And check a pre-existing step
    Then submit the form
    And it should be saved

  Scenario: If a scenario has examples I must be able to see them.
    Given we have a stories with examples
    When I am on "a story"
    Then we should the example should be displayed