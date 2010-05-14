Feature: Lighthouse integration
  In order pull in potential features from lighthouse
  As the system
  I want to be able to retrieve a list of features
  
  Scenario: We should be able to talk to lighthouse
    Given we are using the account name "baphled"
    And we have an the project number "50164"
    When we specify the ticket type "state:open tagged:feature"
    When we retrieve tickets

  Scenario: We need a place to edit our lighthouse resource information
    Given I visit the parking page
    When I use the "New Resource information" link
    Then I should be sent to the "New Resource" page
  
  Scenario: We want to be able to add a new lighthouse resource
    Given we visit the new parking page
    When I fill in the "parking_project_name" with "baphled"
    And I fill in the "parking_project_id" with "50164"
    And we submit the form
    Then the resource information should be saved
  
  Scenario: We should be able to use the lighthouse resource when it has been stored
    Given we have setup the lighthouse resource
    And I visit the parking page
    When I fill in the "parking_tag" with "feature"
    Then we should be sent to the "tickets" page
    And we submit the form
    And there should be a list of tickets found
    
  Scenario: We should be able to import all found tickets into the parking area.
    Given we have set up the lighthouse resource
    And I visit the parking page
    When we submit a ticket search for "feature"
    And we specify the ticket type as "feature"
    Then we should be able to select tickets to add to parking