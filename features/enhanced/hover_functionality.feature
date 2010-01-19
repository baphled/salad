Feature: Hovering over a project item
    In order to view more information when hovering over an item
    As a user
    I want to be able to hover over the item, which in turn displays more information

    Scenario: Hovering over a project item
      Given there are projects
      And I visit the projects index page
      When the first project is hovered over
      Then the project's information will be display in the sidebar