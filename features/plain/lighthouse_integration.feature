Feature: Lighthouse integration
  In order pull in potential features from lighthouse
  As a user
  I want to be able to retrieve a list of features
  
  Scenario: We should be able to retrieve tickets from Lighthouse
    Given I are using the account name "baphled"
    And I have an the project number "50164"
    When I specify the ticket type "state:open tagged:feature"
    When I retrieve tickets

  Scenario: There should be a place to edit our Lighthouse resource information
    When I am on "parking index"
    When I follow "New Resource information"
    Then I should be sent to the "New Resource" page

  Scenario: I should be able to create a new Lighthouse resource
    When I am on "parking new"
    And I fill in the resource form
    Then submit the form
    And the resource information should be saved
  
  Scenario: I should be able to use the lighthouse resource when it has been stored
    Given I have set up the lighthouse resource
    When I am on "parking index"
    And I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    And there should be a list of tickets found
    
  Scenario: I should be able to import all found tickets into the parking area.
    Given I have set up the lighthouse resource
    When I am on "parking index"
    And I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    Then I should be able to select tickets to add to parking

  Scenario: All parked tickets should be displayed on the index page
    Given I have set up the lighthouse resource
    And there are parked tickets on the system
    When I am on "parking index"
    Then a list of parked ticket should be displayed
    
  Scenario: I should be able to save the selected tickets as parked item
    Given I have set up the lighthouse resource
    When I am on "parking index"
    And I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    Then I should be able to select tickets to add to parking
    # Need to refactor so that we have a stubbed version of this ticket, will break once ticket is closed
    When I check "lighthouse[ticket_id][]"
    And I press "Park"
    Then one item should be saved as parked items
    
  Scenario: A ticket should not be saved if the title and its content are found on the system
    Given I have set up the lighthouse resource
    And I have a tickets that is invalid
    When I am on "parking index"
    And I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    # Need to refactor so that we have a stubbed version of this ticket, will break once ticket is closed
    When I check "lighthouse[ticket_id][]"
    And I press "Park"
    Then the flash message "Unable to save tickets" should be displayed
    
  Scenario: A ticket should not be save if any one of the tickets are invalid
    Given I have set up the lighthouse resource
    And there are no tickets parked
    When I am on "parking index"
    And I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    Then I should be able to select tickets to add to parking
    And I should not see a list of tickets to import
    
  Scenario: I should be able to view a tickets description body
    Given I have set up the lighthouse resource
    And there are no tickets parked
    When I am on "parking index"
    And I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    And I check "lighthouse[ticket_id][]"
    And I press "Park"
    Then the save tickets should have a body

  Scenario: I should not be able to import tickets if a resource has not been set up
    Given there are no resources
    When I am on "parking index"
    Then the ticket search form should not be visible.

  Scenario: I should be able to view a tickets title
    Given I have set up the lighthouse resource
    And there are no tickets parked
    When I am on "parking index"
    And I select "baphled" from "resource_id"
    And I fill in "parking_tag" with "feature"
    And submit the form
    And I check "lighthouse[ticket_id][]"
    And I press "Park"
    Then the saved tickets should have a title
    
  Scenario: I should be able to convert a parked ticket in into a feature
    Given I are using the account name "baphled"
    And I have an the project number "50164"
    And there are tickets
    When I am on "parking index"
    And I click on the first ticket
    Then the feature form should be displayed