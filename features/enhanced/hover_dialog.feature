Feature: Hover dialog
    In order to help the user to select tags
    As the system
    I want to provide a hover dialog box with pre-existing tags

    Scenario: It should show all tags when the hover dialog for a new project is active
      Given there is a project
      And a project has tags
      When I am on "new project"
      And focus on the tag input
      Then I should see a hover dialog box
      And it should have a list of all project tags

    Scenario: A project tag should not be displayed if the tag is present in the tag input
      Given there is a project
      And a project has tags
      When I am on "new project"
      And I fill in "project_tag_list" with "Project management"
      And focus on the tag input
      Then I should see a hover dialog box
      And the tag input should not contain "Project management"

    Scenario: it should not be displayed if there are no tags in the response
      When I am on "new project"
      And focus on the tag input
      Then I should not see a hover dialog box
      
    Scenario: It should not be visible when focus is taken away from the tag input
      Given there is a project
      And a project has tags
      When I am on "new project"
      And focus on the tag input
      Then I should see a hover dialog box
      When focus is off the tag input
      Then I should not see a hover dialog box