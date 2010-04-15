Feature: Deleting a project should give the user the choice of removing all its associated features or not
    In order to keep the system clean
    As an user
    I want to be able to decide if a deleting a project should remove its features

    Scenario: We should be asked whether we want to remove a projects features along with the project
      Given there is a project
      And the project has features
      When the project is viewed
      And we try to delete the project
      Then we should see a list of features associated with the project
      And we should be asked whether we want to delete the features also

    Scenario: We should be able to select which feature we want to globally remove when deleting a project
      Given there is a project
      And the project has features
      When the project is viewed
      And we try to delete the project
      Then we should see a list of features associated with the project
      And we should be asked whether we want to delete the features also
      And only the selected feature should be deleted