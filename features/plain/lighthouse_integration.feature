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
    When I fill in "resource_name" with "baphled"
    And I fill in "resource_project_id" with "50164"
    Then submit the form
    And the resource information should be saved
  
  Scenario: We should be able to use the lighthouse resource when it has been stored
    Given we have set up the lighthouse resource
    And I visit the parking page
    When I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    And there should be a list of tickets found
    
  Scenario: We should be able to import all found tickets into the parking area.
    Given we have set up the lighthouse resource
    And I visit the parking page
    When I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    Then I should be able to select tickets to add to parking
    
  Scenario: We need to be able to save the selected tickets and save them as parked item
    Given we have set up the lighthouse resource
    And I visit the parking page
    When I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    Then I should be able to select tickets to add to parking
    # Need to refactor so that we have a stubbed version of this ticket, will break once ticket is closed
    When I check "ticket_item[]"
    And I press "Park"
    Then one item should be saved as parked items

  Scenario: We should display all parked tickets on the index page
    Given we have set up the lighthouse resource
    And there are parked tickets on the system
    When I visit the parking page
    Then a list of parked ticket should be displayed