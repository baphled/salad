Feature: Client side validations for our parking form
    In order to improve the user experience when creating new resource
    As an user
    I want the input validated my client side validation

    Scenario: The parking resource name must be entered
      When I am on the "parking index" page
      And I follow "New Resource information"
      And I fill in the resource form name with ""
      Then submit the form
      And a JS based error message should be displayed
      And the form should have an client side error

    Scenario: The parking resource project must be entered
      Given I can view the parking page
      When I follow "New Resource information"
      And I fill in the resource form project with ""
      Then submit the form
      And a JS based error message should be displayed
      And the form should have an client side error

    Scenario: The parking resource name must be at least 3 characters
      Given I can view the parking page
      When I follow "New Resource information"
      And I fill in the resource form name with "fo"
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Please enter at least 3 characters."

    Scenario: The parking resource project must be at least 3 characters
      Given I can view the parking page
      When I follow "New Resource information"
      And I fill in the resource form project with "fo"
      Then submit the form
      And a JS based error message should be displayed
      And the client side error message should be "Please enter at least 3 characters."