Feature: Must be able to do client side validations on our forms
    In order for us to save on resources
    As a user
    I want the form to be validated on the client side

    Scenario: As a user I must give the project a title
      Given I can view the projects page
      When I click new projects
      And we fill in the project aim with 'An aim'
      And we fill in the project description with 'A short description'
      Then submit the form
      And an error message should be displayed
      And the form should have an error class

    Scenario: As a user I must give the project a brief description
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'A project'
      And we fill in the project aim with 'An aim'
      Then submit the form
      And an error message should be displayed
      And the form should have an error class

    Scenario: As a user I must give the project an aim
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'A project'
      And we fill in the project description with 'A short description'
      Then submit the form
      And an error message should be displayed
      And the form should have an error class

    Scenario: As a user I must give the project a brief description when editing a project
      Given there is a project
      When I click new projects
      And we fill in the project title with 'A project'
      And we fill in the project aim with 'An aim'
      Then submit the form
      And an error message should be displayed
      And the form should have an error class

    Scenario: A projects title should be no less than 3 letters long
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'so'
      And we fill in the project aim with 'An aim'
      And we fill in the project description with 'A description'
      Then submit the form
      And an error message should be displayed
      And the the error message should be "Please enter at least 3 characters."
