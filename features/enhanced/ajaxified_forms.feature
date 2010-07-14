Feature: All our forms need to be passed to the server via AJAX
  In order to improve the users experience
  As a user
  I want to be able to create new items without having the page refresh when the forms submitted

  Scenario: We should be able to submit a new project form via AJAX
    Given I can view the projects page
    When I click new projects
    And we fill in the project title with 'A project'
    And we fill in the project aim with 'An aim'
    And we fill in the project description with 'A description'
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "Project: A project was created" should be dynamically displayed

  Scenario: We should be able to submit an editted project form via AJAX
    Given there is a project
    And I visit the projects edit view
    When we fill in the project aim with 'A different aim'
    Then submit the form
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed

  Scenario: We should be able to submit a new feature form via AJAX
    Given I can view the features page
    And there are projects
    When I click new features
    And we fill in the feature title with 'Logging in via an ajax request'
    And we fill in the feature in_order with 'to create the best app'
    And we fill in the feature as_a with 'user'
    And we fill in the feature i_want with 'the best project ever'
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was created" should be dynamically displayed

  Scenario: We should be able to submit an editted feature form via AJAX
    Given I can view the features page
    When I edit the first feature
    And we fill in the feature title with 'an edited title'
    And submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed

  Scenario: We should be able to submit a new story form via AJAX
    Given I can view the features page
    And there are features
    When I select first feature new story link
    And we fill in the story scenario with 'this is our AJAX based stories scenario'
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was created" should be dynamically displayed

  Scenario: We should be able to submit an editted story form via AJAX
    Given I can view the stories page
    And there are stories
    When I edit the first story
    And uncheck a feature it is associated to
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed

  Scenario: We should be able to submit a created step form via AJAX
    Given I can view the steps page
    When I click new steps
    Then the new step form should be displayed
    When we fill in the step title with 'Given we have a new AJAX step'
    Then submit the form
    And the form should be hidden
    And a flash message "was created" should be dynamically displayed

  Scenario: We should be able to submit an editted step via AJAX
    Given I can view the stories page
    And there are stories
    When I edit the first story
    And uncheck a feature it is associated to
    Then submit the form
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed
    
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

  Scenario Outline: When submitting a form the hover functionality should still be available
     Given the "<page name>" has "<assoc item>"
     When I am on the <page>
     And I submit the form
     And the <assoc> page is loaded
     And the first <assoc> is hovered over
     Then the <assoc>'s information will be display in the sidebar

  Examples: List of forms that should display flash messages after submitting a form
    | page name | assoc   | page         |
    | project   | feature | edit project |
    | feature   | story   | edit feature |
    | story     | step    | edit story   |
    
  Scenario Outline: The ordering button should not be on any of the model index pages
    Given there is a <model>
    When I view the "<page name>" path
    And fill in the <model> form
    And submit the form
    Then it should "<have order button>" have an order button

  Examples: List of pages that use the list layout
    | model   | page name    | have order button |
    | project | new project  | does not          |
    | feature | new feature  | does not          |
    | story   | new story    | does not          |
    | step    | new step     | does not          |
    | project | edit project | does              |
    | feature | edit feature | does              |
    | story   | edit story   | does              |
    | step    | edit step    | does not          |

  Scenario Outline: The items summary information should always be displayed
    Given there is a <model>
    When I view the "<page name>" path
    And fill in the <model> form
    And submit the form
    Then it should display all the <model> information
      
  Examples: List of actions that should render the information and summary panel
    | model   | page name    |
    | project | new project  |
    | project | edit project |
    | feature | new feature  |
    | feature | edit feature |
    | story   | new story    |
    | story   | edit story   |
    | step    | new step     |
    | step    | edit step    |
