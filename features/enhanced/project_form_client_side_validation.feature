Feature: Must be able to do client side validations on our forms
    In order for us to save on resources
    As a user
    I want the form to be validated on the client side

    Scenario: A user gets a JS error if the title is not valid
      Given I can view the projects page
      When I click new projects
      And we fill in the project aim with 'An aim'
      And we fill in the project description with 'A short description'
      Then submit the form
      And a JS based error message should be displayed
      And the form should have an client side error

    Scenario: A user gets a JS error if the description is not valid
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project aim with 'An aim'
      Then submit the form
      And a JS based error message should be displayed
      And the form should have an client side error

    Scenario: A user gets a JS error if the aim is not valid
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project description with 'A short description'
      Then submit the form
      And a JS based error message should be displayed
      And the form should have an client side error

    Scenario: A user gets a JS error if the description is not valid when editing a project
      Given there is a project
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project aim with 'An aim'
      Then submit the form
      And a JS based error message should be displayed
      And the form should have an client side error

    Scenario: A user gets a JS error if the title is less than 3 letters long
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'so'
      And we fill in the project aim with 'An aim'
      And we fill in the project description with 'A description'
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Please enter at least 3 characters."

    Scenario: A user gets a JS error if the aim is less than 6 characters long
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project aim with 'somit'
      And we fill in the project description with 'A description'
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Please enter at least 6 characters."

    Scenario: A user gets a JS error if A projects description should be no less than 12 characters long
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project aim with 'An aim'
      And we fill in the project description with 'too short'
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Please enter at least 12 characters."

    Scenario: A user gets a JS error if A projects location must be a valid project location on their system
      Given I can view the projects page
      When I click new projects
      And we fill in the project location with '/s'
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Must be a valid project location on your system."

    Scenario: No JS errors should be shown if the project is valid
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'WorldPeace2.0'
      And we fill in the project aim with 'An aim'
      And we fill in the project description with 'A description'
      Then submit the form
      And I should be redirected to the new project
      
   Scenario: An project that is not unique must return the relevant client side error
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'A fixture project'
      And we fill in the project aim with 'A description for our project'
      And we fill in the project description with 'A projects aims'
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Must be a unique project."