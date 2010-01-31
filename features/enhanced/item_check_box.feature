Feature: We should be able to easily general checkbox items
    In order to improve the users experience
    As a checkbox
    I want to be able to easily generate a check box list

    Scenario: Generating a basic check box
      Given there are projects
      And the project has features
      When I visit the projects edit view
      Then I should see a "view features" link
      When I press view features checkbox list
      Then I should see a "hide features" link
      Then the list of feature checkboxes should be viewable
