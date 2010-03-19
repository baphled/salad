Feature: We need a way to keep our local feature files in sync with what is on the system
    In order to help manage our features, we want to be able to easily sync Salad with our project features
    As a user
    I want to be able to update Salad to reflect any local changes made to a project features

    Scenario: An existing feature has been changed
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      Then I should be alerted if a feature file has changed
      And a "view changes" link should be displayed within the feature
      
    Scenario: An existing features story has changed
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      Then I should be alerted if a feature file has changed
      When we click the features "view changes"
      Then we should see the changes to the files
      And "Something different" should be highlighted
          
    Scenario: A user should be redirected back to the feature when they try to access changes that does not exist
      Given we have a valid feature file
      And the feature file is saved
      When the features changes is viewed
      Then the flash message "No changes available" should be displayed
      
    Scenario: A user should be able to update the system with the changes made to a feature file
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      Then I should be alerted if a feature file has changed
      When we click the features "view changes"
      Then we should see the changes in the file
      And there should be a link to merge the change