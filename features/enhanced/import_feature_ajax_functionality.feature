Feature: Import feature AJAX functionality
  In order to improve the user experience
  As a user
  I want the import view to be re-rendered once the import form has been submitted
  
  Scenario: Importing a feature via AJAX should re-render the import view
    Given there is a project with "location" as "RAILS_ROOT"
    When I am on "a project"
    And I click "span.view-panel"
    Then the import link should be visible
    When I click "a#import"
    Then I should see the imports page
    When I import "button.button"
    Then there should be an AJAX request
    And the imports will be rendered via AJAX

  Scenario: Clicking on a feature tab should display the importable feature
    Given there is a project with "location" as "RAILS_ROOT"
    When I am on "a project"
    And I click "span.view-panel"
    Then the import link should be visible
    When I click "a#import"
    Then I should see the imports page
    And select the "Tag cloud" tab
    Then the "Import tag cloud" button should be visible

  Scenario: Upon importing a feature the related tab should be removed
    Given there is a project with "location" as "RAILS_ROOT"
    When I am on "a project"
    And I click "span.view-panel"
    Then the import link should be visible
    When I click "a#import"
    Then I should see the imports page
    And select the "Tag cloud" tab
    And I click "button.button"
    Then the "Tag cloud" tab should not be visible

  Scenario: Upon importing a feature a flash message should be displayed
    Given there is a project with "location" as "RAILS_ROOT"
    When I am on "a project"
    And I click "span.view-panel"
    Then the import link should be visible
    When I click "a#import"
    Then I should see the imports page
    And select the "Tag cloud" tab
    And I click "button.button"
    Then the flash message "was created" should be displayed

  Scenario: Importing a feature should disable the submit button on submission
    Given there is a project with "location" as "RAILS_ROOT"
    When I am on the "import project" page
    And I import "button.button"
    Then the submit button should be disabled