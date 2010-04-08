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
      And a "view changes" link should be displayed within the feature
      
    Scenario: An existing features story has changed
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      When we click the features "view changes"
      Then we should see the changes to the files
      And "Something different" should be highlighted as added

    Scenario: A user should be redirected back to the feature when they try to access changes that does not exist
      Given we have a valid feature file
      And the feature file is saved
      When the features changes is viewed
      Then the flash message "No changes available" should be displayed
      
    Scenario: A user should be able to update the system with the changes made to a feature on the system
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      When we click the features "patch changes"
      Then we should see the changes on the system
      When I view the feature
      And there should be a link to merge the change

    Scenario: We must be able to view the changes we are about to merge
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And the feature file has changed
      When I view the feature
      And we click the features "merge changes"
      Then I should see "Dry-run"

    Scenario: We need a way to do a dry-run patch on our feature file
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And the feature file has changed
      When I view the feature
      And we click the features "merge changes"
      And I use the "Dry-run" link
      Then the flash message "No errors whilst doing dry-run" should be displayed
      And we should be redirected back to "merge"

    Scenario: We need a way to to patch on our feature file
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And the feature file has changed
      When I view the feature
      And we click the features "merge changes"
      And I use the "Patch" link
      Then the flash message "Feature has been patched" should be displayed
      
    Scenario: We need to be able to update a source file with changes made to a system feature
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      And the system feature has changed
      When view the feature
      And we click the features "merge changes"
      And I use the "Patch file" link
      Then the flash message "Feature has successfully been patched" should be displayed
      And the source file should be identical to the system file
      Then we should be able to update our source file