Feature: All item information should be layed out in a similar way
    In order to give the system a similar feel
    As a user
    I want to see item information in a generic format

    Scenario: Viewing a project should display the project information in a pre defined layout
      Given there is a project
      When the project is viewed
      Then the "project" information header should be displayed
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

    Scenario: Viewing a feature should display the feature information in a pre defined layout
      Given there is a feature
      When the feature is viewed
      Then the "feature" information header should be displayed
      And the "Title" should be displayed
      And the "In order" should be displayed
      And the "I want" should be displayed
      And the "As a" should be displayed
      And the "Creation date" should be displayed
      And the "Updated date" should be displayed
      And a "Total number of Stories"
      And a "Last Story"

    Scenario: Viewing a features stories should display the features information in a pre defined layout
      Given the feature has stories
      When I visit the features stories
      Then it should display all the feature information

    Scenario: Viewing a story should display the story information in a pre defined layout
      Then the "story" information header should be displayed
      And the "Scenario" should be displayed
      And a "Total number of Steps"
      And a "Last Step"

    Scenario: Viewing a storys steps should display the storys information in a pre defined layout
      Given the story has steps
      When I visit the storys steps
      Then it should display all the story information

    Scenario: Viewing a step should display the step information in a pre defined layout
      Then the "step" information header should be displayed
      And the "Title" should be displayed