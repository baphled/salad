Feature: Stories need to be validated
  In order to validate our stories
  As a system process
  I want to validate story attributes

  Scenario: We must have a valid feature
    Given I can view the stories page
    When I use the "New Story" link
    Then submit the form
    And the "story" "scenario" "input" should have an error class

  Scenario: An invalid scenario should have a related error message
    Given I can view the stories page
    When I use the "New Story" link
    And we fill in the story scenario with 'this'
    Then submit the form
    And the error message should be "Please enter at least 7 characters."
  
  Scenario: If a story is not unique we need to display a error
    Given I can view the stories page
    When I use the "New Story" link
    And we fill in the story scenario with 'my stories 1st scenario'
    Then submit the form
    And the error message should be "has already been taken"