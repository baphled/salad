Feature: AJAX based Sidebar functionality
  In order to keep the functionality consistent
  As a user
  I want to be able to submit a form and have the side bar along with its hover items available to the user

  Scenario Outline: Displaying the side bar after form submission
    Given there is a <model>
    When I view the "<page name>" path
    Then the side bar should not be rendered
    And submit the form
    And there should be an AJAX request
    And the sidebar will be rendered via AJAX
    
  Examples: All pages that should have render the sidebar after an AJAX based form submission
     | model   | page name    |
     | project | edit project |
     | feature | edit feature |
     | story   | edit story   |
     | step    | edit step    |