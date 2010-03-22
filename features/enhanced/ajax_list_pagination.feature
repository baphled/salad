Feature: Pagination should be done with AJAX if possible
    In order to help improve the users experience we will use AJAX to manipulate the pagination functionality
    As a user
    I want to be able to request a new page and not have the whole page refresh

    Scenario: When requesting the next page, a loading message should appear
      Given there is a project
      And the project has more than 5 features
      When I visit the projects features
      And the feature page is loaded
      And we click page "2"
      Then the JS message "Page loading..." should be displayed
      When I visit the projects features
      And the feature page is loaded

    Scenario: All lists should display the current page they are one
      Given there is a project
      And the project has more than 5 features
      When I visit the projects features
      And the feature page is loaded
      And we click page "2"
      Then the JS message "Page loading..." should be displayed
      And the current page number should be displayed

    Scenario: Requesting a new page should not refresh the whole page
      Given there is a project
      And the project has more than 5 features
      When I visit the projects features
      And the feature page is loaded
      And we click page "2"
      Then the page should not refresh
      And there should be an AJAX request
      And the list content should be updated

    Scenario: When getting a new page I must still be able to hover over a feature and view its stories
      Given there is a project
      And the project has more than 5 features
      When I visit the projects features
      And the feature page is loaded
      And we click page "2"
      And the first feature is hovered over
      Then the features information will be display in the sidebar