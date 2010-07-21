Feature: Stories need client side validation
  In order to validate our stories
  As a system process
  I want to validate story attributes

  Scenario: An client side error is returned if there is no story
    When I am on "new story"
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error

  Scenario: An invalid scenario should have a related error message
    When I am on "new story"
    And we fill in the story scenario with 'this'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Please enter at least 7 characters."
  
  Scenario: If a story is not unique we need to display a client side error
    Given there is a story
    When I am on "new story"
    And I fill in the story form with duplicate data
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be a unique story."