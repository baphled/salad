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
      And a summary of the project should be displayed
      And the form should be hidden
      And a flash message "Project: A project was created" should be dynamically displayed


    Scenario: We should be able to submit an editted project form via AJAX
      Given there is a project
      And I visit the projects edit view
      When we fill in the project aim with 'A different aim'
      Then submit the form
      And a summary of the project should be displayed
      And the form should be hidden
      And a flash message "was updated" should be dynamically displayed