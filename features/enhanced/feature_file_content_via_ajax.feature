Feature: feature file content via AJAX
  In order to enhance the users experience
  As a user
  I want to be able to view a features files content via a dialog box

  Scenario: I should be able to click a link and the content should be displayed
    Given there is a feature
    When I am on "a feature" page
    When I use the features path link
    Then there should be an AJAX request
    And a dialog box should appear