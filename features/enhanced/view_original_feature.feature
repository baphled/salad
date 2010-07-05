Feature: view an original feature file
  In order to enhance the users experience
  As a user
  I want to be able to view the original feature file content

  Scenario: When clicking on a features path the users should see the file contents in a dialog box
    Given I have a feature
    When I am on "a feature"
    And I click the features path
    Then a dialog box should appear
    And the features content should be displayed