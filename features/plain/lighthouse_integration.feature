Feature: Lighthouse integration
  In order pull in potential features from lighthouse
  As the system
  I want to be able to retrieve a list of features
  
  Scenario: We should be able to talk to lighthouse
    Given we are using the account name "baphled"
    And we have an the project number "50164"
    When we specify the ticket type "state:open tagged:feature"
    When we retrieve tickets
    
  Scenario: We want to be able to get a list of tickets using the give tag
    Given there is a parking area
    And we click import tickets
    When we submit the search
    Then should have a list of all tickets we would like to import
    
  Scenario: We should be able to import all found tickets into the parking area.
    Given there is a parking area
    When we the page loads we should have a list of all tickets we would like to import
    Given we are using the account name in the config file
    And we have an the project number in the config file
    When we visit the "parking" page
    And we specify the ticket type as "feature"
    And we submit the search
    Then it should display a list of tickets that could be saved as parked features