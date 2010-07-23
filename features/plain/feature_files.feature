Feature: We need a way to handle cucumber feature files
  In order to improve the way we handle feature imports
  As a Salad feature
  I want to be able to read feature files and store its information

  Scenario: A FeatureFile can gives an error if the file referenced is not a cucumber feature file
    Given we create a FeatureFile from a none cucumber feature file
    Then the object should be invalid

  Scenario: A FeatureFile should be valid if the file references is a cucumber file
    Given we create a FeatureFile from a cucumber feature file
    Then the object should be valid

  Scenario Outline: A FeatureFile should store the all feature information
    Given we create a FeatureFile from a cucumber feature file
    Then the object should be valid
    And the '<property>' property should not be nil

  Examples: List of properties that should not be nil
    | property |
    | title    |
    | in_order |
    | as_a     |
    | i_want   |
    | stories  |

  Scenario: A FeatureFile should store the feature files scenario's
    Given we create a FeatureFile from a cucumber feature file
    Then the object should be valid
    And the object should have 1 or more scenarios

  Scenario: A FeatureFile should store a scenarios steps
    Given we create a FeatureFile from a cucumber feature file
    Then the object should be valid
    And the object should have 1 or more scenarios
    And each scenario should have the expected steps

  Scenario: A FeatureFile should be able to save a features scenarios & steps
    Given we create a FeatureFile from a cucumber feature file
    When a feature is valid
    And it has more than one scenario
    Then export will return a Feature object
    And the feature should have stories
    And these stores should have steps

  Scenario Outline: When exporting a feature we want to make sure we get rid of the prefixes
    Given we create a FeatureFile from a cucumber feature file
    When a feature is valid
    And it has more than one scenario
    Then export will return a Feature object
    And exported features '<property>' will not contain '<prefix>' prefix
    And each scenario should not be prefixed with 'Scenario:'

  Examples: List of properties that should not contain the given prefixes
    | property | prefix   |
    | title    | Feature: |
    | in_order | In order |
    | i_want   | I want   |
    | as_a     | As       |
