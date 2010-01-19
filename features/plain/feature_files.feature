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
    Scenario: A FeatureFile should store the 'I want' heading
    Scenario: A FeatureFile should store the feature files scenario's