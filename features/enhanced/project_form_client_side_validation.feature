Feature: Must be able to do client side validations on our forms
    In order for us to save on resources
    As a user
    I want the form to be validated on the client side

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