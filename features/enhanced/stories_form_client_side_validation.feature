Feature: Stories need client side validation
  In order to validate our stories
  As a system process
  I want to validate story attributes

  Scenario: An client side error is returned if there is no story
    Given I can view the stories page
    When I use the "New Story" link
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Scenario: An invalid scenario should have a related error message
    Given I can view the stories page
    When I use the "New Story" link
    And we fill in the story scenario with 'this'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least 7 characters."
  
  Scenario: If a story is not unique we need to display a client side error
    Given I can view the stories page
    When I use the "New Story" link
    And we fill in the story scenario with 'my stories 1st scenario'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be unique"