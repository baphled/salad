Feature: Must be able to deal with our projects validations on our forms
    In order for us to save on resources
    As a user
    I want the form to be validated on the back end
      
    Scenario: A project must be unique
      Given I can view the projects page
      When I click new projects
      And we fill in the project title with 'A fixture project'
      And we fill in the project aim with 'A description for our project'
      And we fill in the project description with 'A projects aims'
      Then submit the form
      And the project information should not be saved
      And the error message should be "has already been taken"