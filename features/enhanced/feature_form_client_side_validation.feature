Feature: Feature forms should have client side validations
  In order to improve the performance of the salad
  As a system feature
  I want to allow for validation of the feature forms
    
  Scenario: A feature must be unique
    Given there is a feature
    When I am on "new feature"
    And I fill in the feature form with existing data
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be a unique feature."