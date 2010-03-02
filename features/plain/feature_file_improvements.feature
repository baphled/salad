Feature: We want to be able to deal with Cucumber changing formats easily
    In order to improve the way our features files are imported
    As part of the system
    I want to be able to use cucumbers functionality to read our feature files

    Scenario: We should be able to parse a feature file using Cucumbers exisint functionality
      Given we have a feature file
      And the feature file can be opened with Cucumbers FeatureFile object
      When we parse a file
      Then our parse FeatureFile should be called

    Scenario: We should be able to extract a scenario outline
      Given we have a feature file
      And the feature file can be opened with Cucumbers FeatureFile object
      When we parse a file
      Then a scenario outline should be found

    Scenario: We should be able to extract a scenarios examples
      Given we have a feature file
      And the feature file can be opened with Cucumbers FeatureFile object
      When we parse a file
      Then a scenario outline should be found
      And the scenario outlines example should be found
