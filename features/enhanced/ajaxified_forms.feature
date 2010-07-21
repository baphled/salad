Feature: All our forms need to be passed to the server via AJAX
  In order to improve the users experience
  As a user
  I want to be able to create new items without having the page refresh when the forms submitted

  Scenario: We should be able to submit a new project form via AJAX
    When I am on "new project"
    And I fill in the project form
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was created" should be dynamically displayed

  Scenario: We should be able to submit an editted project form via AJAX
    Given there is a project
    And I am on "edit project"
    When we fill in the project aim with 'A different aim'
    Then submit the form
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed

  Scenario: We should be able to submit a new feature form via AJAX
    When I am on "new feature"
    And I fill in the feature form
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was created" should be dynamically displayed

  Scenario: We should be able to submit an editted feature form via AJAX
    Given there is a feature
    When I am on "edit feature"
    And we fill in the feature title with 'an edited title'
    And submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed

  Scenario: We should be able to submit a new story form via AJAX
    Given there are features
    When I am on "all features"
    And I select first feature new story link
    And we fill in the story scenario with 'this is our AJAX based stories scenario'
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was created" should be dynamically displayed

  Scenario: We should be able to submit an editted story form via AJAX
    Given there is a story
    And there are features
    When I am on "edit story"
    And uncheck a feature it is associated to
    Then submit the form
    And there should be an AJAX request
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed

  Scenario: We should be able to submit a created step form via AJAX
    When I am on "new step"
    Then the new step form should be displayed
    When we fill in the step title with 'Given we have a new AJAX step'
    Then submit the form
    And the form should be hidden
    And a flash message "was created" should be dynamically displayed

  Scenario: We should be able to submit an editted step via AJAX
    Given there is a story
    And it has an associated feature
    When I am on "edit story"
    And uncheck a feature it is associated to
    Then submit the form
    And the form should be hidden
    And a flash message "was updated" should be dynamically displayed
    
  Scenario Outline: Displaying the side bar after form submission
    Given there is a <model>
    And the "<page name>" has "<assoc>"
    When I am on "<page name>"
    Then the side bar should not be rendered
    And submit the form
    And there should be an AJAX request
    And the sidebar will be rendered via AJAX

  Examples: All pages that should have render the sidebar after an AJAX based form submission
    | model   | page name    | assoc   |
    | project | edit project | feature |
    | feature | edit feature | story   |
    | story   | edit story   | step    |
    | step    | edit step    |         |

  Scenario Outline: When submitting a form the hover functionality should still be available
    Given there is a <page name>
    And the "<page name>" has "<assoc>"
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
    Given the "<page name>" has 5 "<assoc>"
    When I am on "<page name>"
    And I <form action> the <model> form
    And submit the form
    And there should be an AJAX request
    Then it should "<have order button>" have an order button

  Examples: List of pages that use the list layout
    | model   | page name    | assoc   | have order button | form action |
    | project | new project  | feature | does not          | fill in     |
    | feature | new feature  | story   | does not          | fill in     |
    | story   | new story    | step    | does not          | fill in     |
    | step    | new step     |         | does not          | fill in     |
    | project | edit project | feature | does              | update      |
    | feature | edit feature | story   | does              | update      |
    | story   | edit story   | step    | does              | update      |
    | step    | edit step    |         | does not          | update      |

  Scenario Outline: The items summary information should always be displayed
    Given there is a <model>
    And the "<page name>" has "<assoc>"
    When I am on "<page name>"
    And I <form action> the <model> form
    And submit the form
    And there should be an AJAX request
    Then it should display all the <model> information
      
  Examples: List of actions that should render the information and summary panel
    | model   | page name    | assoc   | form action |
    | project | new project  | feature | fill in     |
    | feature | new feature  | story   | fill in     |
    | story   | new story    | step    | fill in     |
    | step    | new step     |         | fill in     |
    | project | edit project | feature | update      |
    | feature | edit feature | story   | update      |
    | story   | edit story   | step    | update      |
    | step    | edit step    |         | update      |
