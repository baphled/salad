Feature: We need a way to keep our local feature files in sync with what is on the system
    In order to help manage our features, we want to be able to easily sync Salad with our project features
    As a user
    I want to be able to update Salad to reflect any local changes made to a project features

    Scenario: An existing feature has been changed
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I am on a "a feature"
      And a "Check the difference between the systems & your applications features" link should be displayed within the feature
      
    Scenario: An existing features story has changed
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I am on a "a feature"
      When we click the features "Check the difference between the systems & your applications features"
      Then we should see the changes to the files
      And "Something different" should be highlighted as added

    Scenario: A user should be redirected back to the feature when they try to access changes that does not exist
      Given we have a valid feature file
      And the feature file is saved
      When I am on "feature changes"
      Then the flash message "No changes available" should be displayed
      
    Scenario: We must be able to view the changes we are about to merge
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I am on a "a feature"
      Then we click the features "Merge a systems changes with the feature"
      And I should see "Dry-run"

    Scenario: We need a way to do a dry-run patch on our feature file
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I am on a "a feature"
      And we click the features "Merge a systems changes with the feature"
      Then I use the "Dry-run" link
      And the flash message "No errors whilst doing dry-run" should be displayed
      And we should be redirected back to "merge"

    Scenario: We need a way to to patch on our feature file
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And the feature file has changed
      And I am on a "a feature"
      And we click the features "Merge a systems changes with the feature"
      And I use the "Patch" link
      Then the flash message "Feature has been patched" should be displayed
      
    Scenario: We need to be able to update a source file with changes made to a system feature
      Given we have a valid feature file
      And the local feature file has changed
      And I am on a "a feature"
      And we click the features "Merge a features changes with the system"
      And I use the "Update" link
      Then the flash message "The system feature has successfully been updated" should be displayed
      And the source file should be identical to the system file

    Scenario: We need to be able to save a feature stories when a source feature file is changed
      Given we have a valid feature file
      And the feature file is saved
      And the local feature file has changed a featutes scenario
      And I am on a "a feature"
      And we click the features "Merge a features changes with the system"
      And I use the "Update" link
      Then the flash message "The system feature has successfully been updated" should be displayed
      And the source file should be identical to the system file