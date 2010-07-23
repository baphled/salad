Feature: Users should not have to manually input their features if they have already defined them within cucumber. Users should be able to select import, to which the system will parse over their features and generate the necessary associations for their project.
  In order to keep our features synchronised
  As user
  I want to have the functionality to import my cucumber features into salad

  Scenario: I should be able to import feature into a project
    Given there is a project with a valid location
    When I am on "a project"
    Then I should see a import link

  Scenario: I should not see an import link if the project location is not present
    Given there is a project with "location" as ""
    When I am on "a project"
    Then I should not see a import link

  Scenario: I should be able to click the import link
    Given there is a project with a valid location
    When I am on "a project"
    Then I should see a import link
    When I click import
    Then I should see a list of features that will be imported

  Scenario: I should only see files which are actual features
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file

  Scenario: I should be able to view the feature text below the file name of each feature file
    Given there is a project with a valid location
    When I am on "import project"
    Then each entry should be a feature file
    And each entry should display the features feature text

  Scenario: I should not see 'Feature:' in the import display text
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should not have 'Feature:' as a prefix

  Scenario: I should display the 'In order' line
    Given there is a project with a valid location
    When I am on "import project"
    Then each entry should display the features 'In order' text

  Scenario: I should display the 'As a' line
    Given there is a project with a valid location
    When I am on "import project"
    Then each entry should be a feature file
    And each entry should display the features 'As a' text

  Scenario: I should display the 'I want' line
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file
    And each entry should display the features 'I want' text

  Scenario: I should be able to see all the stories for each feature
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file
    And each entry should display the features its stories

  Scenario: I should be able to save a selected feature to import
    Given there is a project with a valid location
    When I am on "import project"
    And select the "Tag cloud"
    And the feature is visible
    And we click import projects
    Then a flash message 'Feature: Something different, was created' should be displayed

  Scenario: All scenario's should display the steps associated to it
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file
    And each entry should display the features its stories
    And each story should display its steps

  Scenario: When should be able to view all 'Given' steps
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file
    And each entry should display the features its stories
    And each story should display its steps
    And the feature should have at least on 'Given'

  Scenario: When should be able to view all 'When' steps
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file
    And each entry should display the features its stories
    And each story should display its steps
    And the feature should have at least on 'When'

  Scenario: When should be able to view all 'Then' steps
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file
    And each entry should display the features its stories
    And each story should display its steps
    And the feature should have at least on 'Then'

  Scenario: A step should be highlighted if it already exists in the system
    Given there is a project
    And the step "Then the tags cloud should be displayed" is created
    And the project does have a project location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And each entry should be a feature file
    And each entry should display the features its stories
    And each story should display its steps
    Given a step already exists
    Then it should be highlighted

  Scenario: All steps should be added
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And we click import projects
    Then a flash message 'was created' should be displayed
    And each imported stories step should be added

  Scenario: A feature should not be viewable if the feature is already added
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And we click import projects
    Then a flash message 'was created' should be displayed
    And each imported stories step should be added
    When I am on "a project"
    Then I should see a import link
    When I click import
    Then the project feature will be not be selectable.

  Scenario: A message should be displayed to the user if there are no features to import
    Given there is a project
    And the project does have a project location with no features to import
    And there are no features to import
    And I am on "import project"
    Then the message 'No features to import.' should be displayed

  Scenario: Successfully importing a feature should redirect back to the import page
    Given there is a project with a valid location
    When I am on "import project"
    Then I should see a list of features that will be imported
    And we click import projects
    Then a flash message 'was created' should be displayed
    And we should be redirected to the projects import page

  Scenario: When importing features, we should be able to find feature regardless of the feature directory structure
    Given there is a project with a valid location
    When I am on "import project"
    Then it should include features from all sub directories within the feature directory

  Scenario: When importing a feature file if the file is invalid then an error is displayed
    Given there is a project with a valid location
    When I am on "import project"
    And the project has an invalid feature
    Then the submit button will be disabled for that feature

  Scenario: When we try to import an invalid feature
    Given there is a project
    And the project does have a project location to an invalid feature
    When I am on "import project"
    Then the submit button will be disabled for that feature

  Scenario: The feature file heading should not contain any underscores
    Given there is a project
    And the project does have a project location to an invalid feature
    When I am on "import project"
    Then each of the features tabs should not include any underscores
    And each of the features title should not include any underscores

  # @todo Find a better way to implement this step
  Scenario: When importing features and a feature file name is shared with another
    Given there is a project
    And the project does have a project location to an invalid feature
    When I am on "import project"
    Then display the feature file for "sample_one" already exists

  Scenario: When importing a feature which has examples, these should be displayed within the given scenario
    Given there is a project with a valid location
    When I am on "import project"
    Then the first story should contain its examples

  Scenario: When importing features, we should be warned if a scenario title has been duplicated
    Given there is a project with a valid location
    And the project has a feature to export with duplicate scenarios
    When I am on "import project"
    Then the submit button will be disabled for "sample_one"

  Scenario: A feature should not be submittable if a duplicate scenario is found in the new feature
    Given there is a project with a valid location
    When I am on "import project"
    Then the submit button will be disabled for that feature "Import sample one"

  Scenario: Should not see the the import link if there are no features to import
    Given there is a project with a valid location
    And there are no projects to import
    When I am on "a project"
    Then I should not see a import link

  Scenario: Should not see the the import link if there are no features to import
    Given there is a project with a valid location
    And there are no projects to import
    When I am on "a project"
    Then I should not see a import all link