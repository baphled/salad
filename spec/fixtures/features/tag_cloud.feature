Feature: Viewing an items tags
  In order to view tags associated to a item
  As a user
  I want to be able to view them on each item index

  Scenario: Displaying the projects tags cloud when there are associated tags available
    Given there are "project" tags
    And the "project" tags are not empty
    When we visit the "projects" index
    Then the tags cloud should be displayed

  Scenario: Displaying the features tags cloud when there are associated tags available
    Given there are "feature" tags
    And the "feature" tags are not empty
    When we visit the "features" index
    Then the tags cloud should be displayed

  Scenario: Displaying the stories tags cloud when there are associated tags available
    Given there are "story" tags
    And the "story" tags are not empty
    When we visit the "stories" index
    Then the tags cloud should be displayed

  Scenario: Displaying the steps tags cloud when there are associated tags available
    Given there are "step" tags
    And the "step" tags are not empty
    When we visit the "steps" index
    Then the tags cloud should be displayed