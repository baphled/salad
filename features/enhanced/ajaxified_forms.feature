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
      And a flash message "Feature: Logging in via ajax, was created" should be dynamically displayed

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