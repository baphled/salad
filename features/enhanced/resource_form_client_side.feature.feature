#
# inspired by Ryan Bates screencast
#
/*
* I can comment this way
*/
# and this way
// and this way
Feature: Client side validations for our parking form
    # Main goal of this project
    In order to improve the user experience when creating new resource
    As an user
    I want the input validated my client side validation

    Scenario: The parking resource name must be entered
      Given I can view the parking page
      When I follow "New Resource information"
      And I fill in "resource_name" with ""
      Then submit the form
      And a JS based error message should be displayed
      And the form should have an client side error