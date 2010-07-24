Feature: Import a single feature
  In order to help keep our features up to date we want an easy way to import a single feature
  As a user
  I want to be able to import a single feature
  
  Scenario: When a feature is not on the system and there is a new feature file, we should have the option to import it
    Given there is a project
    And we have a valid feature file
    And the feature file is not found
    And I am on "import single feature"
    Then I should see the a link to import the feature

  # @TODO Complete scenario
  Scenario: When importing a feature we should be able to click import and then be redirected to the new feature
    Given there is a project
    And we have a valid feature file
    And the feature file is not found
    When I am on "import single feature"
    And we click the "Import tag cloud" feature
    And we submit the new feature
    Then the feature should be save

  # @TODO Complete scenario
  Scenario: We need to make sure that we do not import a feature that is already added to the system
    Given there is a project
    And we have a valid feature file
    And the feature file is not found
    When I am on "import single feature"
    And we click the "Import tag cloud" feature
    And we submit the new feature
    Then the feature should be save