Feature: We need a way to keep our local feature files in sync with what is on the system
    In order to help manage our features, we want to be able to easily sync Salad with our project features
    As a user
    I want to be able to update Salad to reflect any local changes made to a project features

    Scenario: An existing feature has been changed
      Given I have a project
      And the project has features
      When I view the project
      Then I should be alerted if a feature file has changed
      And a "view changes" link should be displayed within the feature
      
    Scenario: An existing features story has changed
      Given I have a project
      And the project has features
      When I view the project
      Then I should be alerted if a feature file has changed
      When we click the features "view changes"
      Then we should see the changes to the files