Feature: Home page must display the intent of the site

  In order to navigate through the site
  As an user
  I want to be able to know what the site can do for me

  Scenario: Visiting the home page
    Given there is no last project
    When we view the home page
    Then I should see that no projects are on the system
    And I should be instructed on how to add a project

  Scenario: visiting the home page when projects have been created should display the latest projects
    Given there is a last project
    When we view the home page
    Then the latest projects should be displayed
    And there should not be instructions on how to add a project