Feature: Stories need to be validated
  In order to validate our stories
  As a system process
  I want to validate story attributes

  Scenario: If a story is not unique we need to display a error
    Given I can view the stories page
    When I use the "New Story" link
    And we fill in the story scenario with 'my stories 1st scenario'
    Then submit the form
    And the error message should be "has already been taken"