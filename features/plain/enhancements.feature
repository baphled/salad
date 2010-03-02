Feature: We want to make sure that users use javascript to take advantage of all the site functionality
  In order to give to get the most of the system
  As a user
  I want to be informed whether I have JS enabled.
  
  Scenario Outline: When a user visits the site without JS enable we want to display a header notifying them that the site works best with JS
    Given I can view the <page> page
    Then the message 'This site works best with Javascript enabled' should be displayed
  
  Scenarios:
  | page     |
  | /        |
  | projects |
  | features |
  | stories  |
  | steps    |