Feature: We want to us different layout for specific types of actions and areas
  In order to help inform the user that specific actions have different layouts associated to them
  As an user
  I want to see different layouts for specific actions and areas

  Scenario: Viewing the all forms should display te no sidebar layout
    When I view the "projects" "new"
    Then the view should not have a sidebar

  Scenario: A project index view should have a sidebar
    When I view the "projects" "index"
    Then the view should have a sidebar