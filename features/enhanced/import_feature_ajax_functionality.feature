Feature: Import feature ajax functionality
  In order to help the user stay within the import view
  As a user
  I want the import view to be re-rendered once the import form has been submitted
  
  Scenario: Importing a feature via AJAX should re-render the import view
    Given there is a project
    And the project has a project path
	  When the project is viewed
	  When I click "span.view-panel"
	  Then the import link should be visible
    When I click "a#import"
    Then I should see the imports page
    When I import "button.button"
    Then there should be an AJAX request
    And the imports will be rendered via AJAX