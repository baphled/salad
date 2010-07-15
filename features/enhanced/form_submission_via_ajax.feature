Feature: Form submission via AJAX
  In order to keep the AJAX based form submission consistent
  As an user
  I want to experience the same kind of user journey regardless of using AJAX or not

  Scenario Outline: A feature we should still see the source feature file contents via a dialog box
    Given there is a <item>
    When I am on "<page>" page
    And I <form action> the <item> form
    Then I submit the form
    Then there should be an AJAX request
    When I use the features path link
    Then there should be an AJAX request
    And a dialog box should appear

  Examples:
    | page          | item      | form action |
    | edit feature  | feature   | update      |

  Scenario Outline: After editing a item the hover dialog should still function
    Given there is a <item>
    When I am on "<page>" page
    And I <form action> the <item> form
    Then I submit the form
    When I click "button.display_form"
    Then there should be an AJAX request

  Examples:
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |

  Scenario Outline: The items panel should be visible
    Given there is a <item>
    When I am on the <page> page
    And I <form action> the <item> form
    Then there should be an AJAX request
    And the icons panel should be visible

  Examples:
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |

  # @TODO Add more pagination related scenarios later
  Scenario Outline: We should still be able to use the pagination
    Given there is a <item>
    When I am on the <page> page
    And I <form action> the <item> form
    Then there should be an AJAX request
    And pagination should be visible

  Examples:
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |

  Scenario Outline: Animated icon panels should still work
    Given there is a <item>
    When I am on the <page> page
    And I <form action> the <item> form
    Then there should be an AJAX request
    And I "click" on the one of the items panel
    Then the panels icons should be visible

  Examples:
    | page            | item      | form action |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |

  Scenario Outline: The submitted form should be hidden
    Given there is a <item>
    When I am on the <page> page
    And I <form action> the <item> form
    Then there should be an AJAX request
    And the for should be hidden

  Examples:
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |

  Scenario Outline: The submitted form can be revealed via a button
    Given there is a <item>
    When I am on the <page> page
    And I <form action> the <item> form
    Then there should be an AJAX request
    And the for should be hidden
    And there should be a "view form" button

  Examples:
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |
