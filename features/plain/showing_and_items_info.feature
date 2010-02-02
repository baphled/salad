Feature: All item information should be layed out in a similar way
    In order to give the system a similar feel
    As a user
    I want to see item information in a generic format

    Scenario: Viewing a project should display the project information in a pre defined layout
      Given there is a project
      When the project is viewed
      Then the project information header should be displayed
      And the "Title" should be displayed
      And the "Location" should be displayed
      And the "Aim" should be displayed
      And the "Creation date" should be displayed
      And the "Updated date" should be displayed
      And a "Total number of Features"

    Scenario: Viewing a project features should display the project information in a pre defined layout
      Given the project has features
      When I visit the projects features
      Then it should display all the project information