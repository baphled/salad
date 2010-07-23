Feature: Stories need client side validation
  In order to validate our stories
  As a system process
  I want to validate story attributes

  Scenario: An client side error is returned if there is no story
    When I am on "new story"
    Then submit the form
    And a JS based error message should be displayed
    And the form should have an client side error
