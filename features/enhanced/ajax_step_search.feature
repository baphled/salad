Feature: Extend the basic steps search feature so that users can dynamically see which steps are found which match their search
    In order to improve the steps search feature
    As a user
    I want to be able to see a dynamic list of steps which match my search criteria

    Scenario: The search bar should display a message when the page is loaded
      Given there are steps
      When I am on "all steps"
      And the page is loaded
      Then the search input should contain "Search for steps"

    Scenario: The search bar should not display a message when there is text in the input box
      Given there are steps
      When I am on "all steps"
      And the page is loaded
      Then the search input should not contain "Search for steps"

    Scenario: Search critieria does not match any steps
      Given there are steps
      When I am on "all steps"
      And I search for steps contain "blah"
      Then the auto-complete will display the message "No results found"

    Scenario: Search criteria matches steps
      Given there are steps
      When I am on "all steps"
      And I search for steps contain "Given"
      Then the auto-complete element will contain a list of results