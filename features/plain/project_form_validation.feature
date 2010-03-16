Feature: Must be able to deal with our projects validations on our forms
    In order for us to save on resources
    As a user
    I want the form to be validated on the back end

    Scenario: A user must input a valid title
      Given I can view the projects page
      When I click new projects
      And we fill in the project aim with 'An aim'
      And we fill in the project description with 'A short description'
      Then submit the form
      And the "project" "title" "input" should have an error class

    Scenario: A user must input a valid aim
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project description with 'A short description'
      Then submit the form
      And the "project" "aim" "input" should have an error class

    Scenario: A user must input a valid description
      Given there is a project
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project aim with 'An aim'
      Then submit the form
      And the "project" "description" "input" should have an error class

    Scenario: A projects title should be no less than 3 letters long
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'so'
      Then submit the form
      And the error message should be "Please enter at least 3 characters."

    Scenario: A projects aim should be no less than 6 characters long
      Given I can view the projects page
      When I click new projects
      And we fill in the project aim with 'somit'
      Then submit the form
      And the error message should be "Please enter at least 6 characters."

    Scenario: A JS error is displayed if a projects description is less than 12 characters long
      Given I can view the projects page
      When I click new projects
      And we fill in the project description with 'too short'
      Then submit the form
      And the error message should be "Please enter at least 12 characters."

    Scenario: A projects location must be a valid project location on their system
      Given I can view the projects page
      When I click new projects
      And we fill in the project location with '/blah/'
      Then submit the form
      And the error message should be "Must be a valid project location on your system."
      
    Scenario: A project must be unique
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'A fixture project'
      And we fill in the project aim with 'A description for our project'
      And we fill in the project description with 'A projects aims'
      Then submit the form
      And the project information should not be saved
      And the error message should be "has already been taken"