Feature: All item information should be layed out in a similar way
    In order to give the system a similar feel
    As a user
    I want to see item information in a generic format

    Scenario: Viewing a project should display the project information in a pre defined layout
      Given there is a project
      And the projects creation date is not the same as the updated date
      When I am on "a project"
      Then the "project" information header should be displayed
      And the "Title" should be displayed
      And the "Location" should be displayed
      And the "Aim" should be displayed
      And the "Creation date" should be displayed
      And the "Updated date" should be displayed

    Scenario: Viewing a project features should display the project information in a pre defined layout
      Given there is a project
      And the project has features
      And the projects creation date is not the same as the updated date
      When I am on "projects features"
      Then it should display all the project information

    Scenario: Viewing a feature should display the feature information in a pre defined layout
      Given there is a feature
      And the "feature" has 5 "stories"
      And the features creation date is not the same as the updated date
      When I am on "a feature"
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
      Given there is a feature
      Given the "feature" has 5 "stories"
      When I am on "features stories"
      Then it should display all the feature information

    Scenario: Viewing a story should display the story information in a pre defined layout
      Given there is a story
      When I am on "a story"
      Then the "story" information header should be displayed
      And the "Scenario" should be displayed
      And a "Total number of Steps"
      And a "Last Step"

    Scenario: Viewing a storys steps should display the storys information in a pre defined layout
      Given there is a story
      Given the story has steps
      When I am on "stories steps"
      Then it should display all the story information

    Scenario: Viewing a step should display the step information in a pre defined layout
      Given there is a step
      When I am on "a step"
      Then the "step" information header should be displayed
      And the "Title" should be displayed
      
    Scenario Outline: If an items has no associated items we should not display 0 but something more informative
      Given there is a <model> with no <associations>
      When I am on "<page>"
      Then the copy "No <associations> associated" should be displayed
      And "Total number of <postfix>" should not be displayed
    
    Examples: No associations for a given action
      | page      | model   | associations | postfix  |
      | a project | project | features     | Features |
      | a feature | feature | stories      | Stories  |
      | a story   | story   | steps        | Steps    |
