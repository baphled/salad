Feature: Patching modified feature files
  In order to help users sync their system features with their project features
  As a user
  I want to be able to get a patch file from the system
  
  Scenario: When a feature on the system has changed we need to be able to easy patch our source file
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      Then I should be alerted if a feature file has changed
      And a "patch changes" link should be displayed within the feature
      
    Scenario: When a feature on the system has changed we need to be able to easy patch our source file
      Given we have a valid feature file
      And the feature file is saved
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      Then I should be alerted if a feature file has changed
      And a "patch changes" link should be displayed within the feature
      When we click the features "patch changes"
      Then we should display the patch