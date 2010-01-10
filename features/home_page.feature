Feature: Home page must display the intent of the site

  In order to navigate through the site
  As an user
  I want to be able to know what the site can do for me

  Scenario: Visiting the home page with no last project
    Given there is no last project
    When we view the home page
    Then I should see that no projects are on the system
    And I should be instructed on how to add a project

  Scenario: visiting the home page when projects have been created should display the latest projects
    Given there is a last project
    When we view the home page
    Then it should be displayed
    And it should display its title
    And it should display when the project was created
    And how many features the project has
    And there should not be instructions on how to add a project

  Scenario: When a last project is present and it has no features we should be told
    Given there is a last project
    And the project has no features
    When we view the home page
    Then it should be displayed
    And it should display a message about the project not having any features