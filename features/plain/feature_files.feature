Feature: We need a way to handle out feature files
    # Main goal of this project
    In order to improve the way we handle feature imports
    As Salad
    I want to be able to read feature files and store its information

    Scenario: A FeatureFile can gives an error if the file referenced is not a cucumber feature file
      Given we create a FeatureFile from a none cucumber feature file
      Then the object should be invalid

    Scenario: A FeatureFile should be valid if the file references is a cucumber file
      Given we create a FeatureFile from a cucumber feature file
      Then the object should be valid

    Scenario: A FeatureFile should store the 'Feature' heading
      Given we create a FeatureFile from a cucumber feature file
      Then the object should be valid
      And the feature property should not be nil
      
    Scenario: A FeatureFile should store the 'In order' heading
      Given we create a FeatureFile from a cucumber feature file
      Then the object should be valid
      And the 'In order' property should not be nil
      
    Scenario: A FeatureFile should store the 'I want' heading
      Given we create a FeatureFile from a cucumber feature file
      Then the object should be valid
      And the 'I want' property should not be nil

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