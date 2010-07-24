Feature: view an original feature file
  In order to enhance the users experience
  As a user
  I want to be able to view the original feature file content

  Scenario: When clicking on a features path the users should see the file contents in a dialog box
    Given there is a feature
    When I am on "a feature"
    And click the features path
    Then there should be an AJAX request
    And a dialog box should appear

  # @TODO Add scenarios for viewing source files for features from a list