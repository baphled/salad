Feature: Patching modified feature files
  In order to help sync their system's features with a project's features
  As a user
  I want to be able to get a patch file from the system
  
  Scenario: I should be able to patch a feature file if the system feature is different
    Given there is a valid feature file
    And the feature is exported
    And the feature file is saved
    When the feature has changed "Something different"
    And I am on "a feature"
    And a "Patch a feature with the systems changes" link should be displayed within the feature
    When we click the features "patch-changes"
    Then we should display the patch

  Scenario: I should be redirected if they try to acess a feature with no patch file
    Given  there is a feature that is not different from the source file
    When I am on "features patch"
    Then the flash message "No patch available" should be displayed

  Scenario: I should be able to acess a features patch in a RESTful way
    Given  there is a feature that is different from the source file
    When I am on "features patch"
    Then the patch should be displayed

  Scenario: I should be redirected back to the feature when they try to access a patch that does not exist
    Given there is a feature that is not different from the source file
    When I am on "features patch"
    Then the flash message "No patch available" should be displayed