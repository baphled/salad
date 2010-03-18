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

    Scenario: A user should be redirected if they try to acess a feature with no patch file
      Given  there is a feature that is not different from the source file
      When we view the feature with the "patch" format
      Then the flash message "No patch available" should be displayed

    Scenario: A user should be able to acess a features patch in a RESTful way
      Given  there is a feature that is different from the source file
      When we view the feature with the "patch" format
      Then the patch should be displayed
      
    Scenario: A user should be redirected back to the feature when they try to access a patch that does not exist
      Given we have a valid feature file
      And the feature file is saved
      When the features diff is viewed
      Then the flash message "No patch available" should be displayed