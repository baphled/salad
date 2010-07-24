Feature: AJAX list pagination
  In order to help improve the users experience
  As a user
  I want to be able to request a new page and not have the whole page refresh

  Scenario: Requesting a new page should not refresh the whole page
    Given there is a project
    And the project has more than 5 features
    When I am on "projects features"
    Then the pagination panel should be displayed
    When I follow "2" within "div.pagination"
    Then there should be an AJAX request

  Scenario: When getting a new page I must still be able to hover over a feature and view its stories
    Given there is a project
    And the project has more than 5 features
    When I am on "projects features"
    Then the pagination panel should be displayed
    When I follow "2" within "div.pagination"
    And the first feature is hovered over
    Then the feature's information will be display in the sidebar

  # @TODO Add scenarios for displaying an overlay whilst the page is loading