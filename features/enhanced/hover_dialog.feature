Feature: When selecting tags we want to be able to select from pre-existing tags easily
    In order to help the user to select tags
    As the system
    I want to provide a hover dialog box with pre-existing tags

    Scenario: When clicking on the projects tag input box should display a hover dialog box
      Given I tags
      And I create a new project
      When focus on the tag input
      Then I should see a hover dialog box

    Scenario: When the project tags hover dialog is displayed, it should display all project tags
      Given I tags
      And I create a new project
      When focus on the tag input
      Then I should see a hover dialog box
      And it should have a list of all project tags

    Scenario: A project tag should not be displayed if the tag is present in the tag input
      Given I tags
      And I create a new project
      And the form has "Project management" as the tag
      When focus on the tag input
      Then I should see a hover dialog box
      And it should have a list of all project tags
      And the tag input should not contain "Project managemnt"

    Scenario: The hover dialog should not be displayed if there are no tags in the response
      Given there are no tags
      And I create a new project
      And the form has "Some tag" as the tag
      When focus is on the tag input
      Then I should not see a hover dialog box