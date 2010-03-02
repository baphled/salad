Feature: We need to be able to easily navigate the website
  In order to help users experience the whole site
  As a user
  I want to be able to easily move around the site using the sites navigation
  
  Scenario Outline: We need to make sure that all pages have navigation
    Given I can view the "<page>" page
    Then the navigation should be displayed
  
  Scenarios:
  | page     |
  | /     |
  | projects |
  | features |
  | stories  |
  | steps    |
