Feature: Lighthouse integration
  In order pull in potential features from lighthouse
  As the system
  I want to be able to retrieve a list of features
  
  Scenario: We should be able to talk to lighthouse
    Given we are using the account name "baphled"
    And we have an the project number "50164"
    When we retrieve tickets
    
  Scenario: We want to be able to get a list of tickets using the give tag
    Given we are using the account name "baphled"
    And we have an the project number "50164"
    When we specify the ticket type "state:open tagged:feature"
    Then each of the features should be using the "feature" tag
    And each feature should be listed on the parking
    
  Scenario: We should be able to import all found tickets into the parking area.
    Given there is a parking area
    And we click import tickets
    When we the page loads we should have a list of all tickets we would like to import
    Given we are using the account name "baphled"
    And we have an the project number "50164"
    When we specify the ticket type "state:open tagged:feature"
    And we submit the search
    Then it should be possible to select which tickets should be saved in the parking section