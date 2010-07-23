Feature: Must be able to do client side validations on our forms
    In order for us to save on resources
    As a user
    I want the form to be validated on the client side

    Scenario: A user gets a JS error if A projects location must be a valid project location on their system
      When I am on the "new project" page
      And we fill in the project location with '/s'
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Must be a valid project location on your system."

    Scenario: No JS errors should be shown if the project is valid
      When I am on the "new project" page
      And I fill in the project form title with "WorldPeace2.0"
      Then submit the form
      And I should be redirected to the new project