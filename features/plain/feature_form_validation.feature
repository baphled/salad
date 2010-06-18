Feature: Feature forms should have client side validations
  In order to improve the performance of the salad
  As a system feature
  I want to allow for validation of the feature forms

  Scenario: A feature must be unique
    Given I can view the features page
    When I click new features
    And there are features
    And we fill in the feature title with 'my first feature'
    And we fill in the feature in_order with 'to create an project'
    And we fill in the feature as_a with 'developer'
    And we fill in the feature i_want with 'to have the skills'
    Then submit the form
    And the feature information should be not saved
    And the error message should be "has already been taken"