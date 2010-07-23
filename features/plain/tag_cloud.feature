Feature: Tag cloud
  In order to view tags associated to a item
  As a user
  I want to be able to view them on each items index

  Scenario Outline: I should see a tag cloud if there are tags associated to the item
    Given there are "<model>" tags
    And the "<model>" tags are not empty
    When I am on "<page name>"
    Then the tags cloud should be displayed

  Examples: List of views that should display the tag cloud
    | model   | page name    |
    | project | all projects    |
    | feature | all features    |
    | story   | all stories     |
    | step    | all steps       |