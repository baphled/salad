Feature: Feature forms should have client side validations
  In order to improve the performance of the salad
  As a system feature
  I want to allow for validation of the feature forms
    
  Scenario: A feature must be unique
    Given I can view the features page
    And the feature already exists
    When I click new features
    And there are features
    And we fill in the feature title with 'my first feature'
    Then submit the form
    And a JS based error message should be displayed
    And the client side error message should be "Must be a unique feature."