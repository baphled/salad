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

    Scenario: A user should be redirected if they try to access a feature that has no changes
      Given I can view the features page
      And there are features
      And there is a feature that is different from the source file
      When we view the feature with the "diff" format
      Then the user should be redirected back
      And the flash message "No diff available" should be displayed

    Scenario: A user should be able to acess a features diff in a RESTful way
      Given I can view the features page
      And there are features
      And there is a feature that is different from the source file
      When we view the feature with the "diff" format
      Then the diff should be displayed