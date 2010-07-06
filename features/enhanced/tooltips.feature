Feature: Tooltips
  In order to help the user to tell what certain buttons do
  As a user
  I want tooltips to be displayed when I hover over a button
  
  Scenario: Tooltip for a features export download button
    Given there is a feature
    When I am on "export feature"
    And I hover over the "css=button.button" button
    Then a tooltip should be visible