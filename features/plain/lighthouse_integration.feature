Feature: Lighthouse integration
  In order pull in potential features from lighthouse
  As the system
  I want to be able to retrieve a list of features
  
  Scenario: We should be able to talk to lighthouse
    Given we have an a project number
    When we make a call to lighthouse
    Then we should get a successful response
    
  Scenario: We want to be able to get a list of tickets using the give tag
    Given we have an a project number
    When we make a ticket request to lighthouse
    Then we should get a successful response
    And receive a list of features
    And each of the features should be using the given tag
    
  Scenario: We should be able to import all found tickets into the parking area.
    Given we have an a project number
    And we specify the ticket type "state:open tagged:feature"
    When we receive a list of tickets
    Then the list should be displayed
    And it should be possible to select which tickets should be saved in the parking section