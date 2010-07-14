Feature: All forms input elements should have hints to help the user fill in a form correctly
    In order to help users submit valid form input
    As an user
    I want to see hints to give me clues as to what data needs to go with what field

    Scenario Outline: A project forms hints
      When I view the "<model>" form
      Then I should see "<tooltip>" within "<selector>"

    Examples: List of form selectors with hints
      |model    | tooltip                                         | selector                        |
      |projects | e.g. A project that creates world peace.        | li#project_title_input          |
      |projects | e.g. A solutions to all the worlds woes         | li#project_description_input    |
      |projects | Our aim is the to solve the worlds problems     | li#project_aim_input            |
      |projects | /home/projects/salad                            | li#project_location_input       |
      |features | e.g. A feature that will solve all our problems | li#feature_title_input          |
      |features | e.g. to create the best feature                 | li#feature_in_order_input       |
      |features | e.g. user                                       | li#feature_as_a_input           |
      |features | e.g. to this feature to solve all our problems  | li#feature_i_want_input         |
      |stories  | e.g. We need a way to solve world hunger        | li#story_scenario_input         |
      |steps    | e.g. Given I have all my marbles                | li#step_title_input             |
