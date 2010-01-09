Feature: Home page must display the intent of the site

  In order to navigate through the site
  As an user
  I want to be able to know what the site can do for me

  Scenario: Visiting the home page
    Given there are no projects
    When we view the home page
    Then I should see that no projects are on the system
    And I should be instructed on how to add a project