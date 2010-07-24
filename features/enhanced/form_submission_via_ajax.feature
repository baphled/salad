Feature: Form submission via AJAX
  In order to keep the AJAX based form submission consistent
  As an user
  I want to experience the same kind of user journey regardless of using AJAX or not

  Scenario Outline: should still be able to see the source feature file contents via a dialog box
    Given there is a <item>
    When I am on "<page>" page
    And I <form action> the <item> form
    When I submit the form
    Then there should be an AJAX request
    When I use the features path link
    Then there should be an AJAX request
    And a dialog box should appear

  Examples: A list of forms that should still allow the user to see view source feature file via a dialog box
    | page          | item      | form action |
    | edit feature  | feature   | update      |

  Scenario Outline: The icons panel should be functional
    Given there is a <item>
    When I am on the <page> page
    And I <form action> the <item> form
    And I submit the form
    Then there should be an AJAX request
    And the icons panel should be visible

  Examples: A list of forms that should render the icons panel after submission
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |

  Scenario Outline: I should still be able to use the pagination
    Given there is a <item>
    And the <item> has more than 5 <assoc>
    When I am on the <page> page
    And I <form action> the <item> form
    And I submit the form
    Then there should be an AJAX request
    And pagination should be visible

  Examples: A list of forms that when submitted should render the pagination functionality
    | page         | item    | assoc   | form action |
    | new project  | project | feature | fill in     |
    | new feature  | feature | story   | fill in     |
    | new story    | story   | step    | fill in     |
    | edit project | project | feature | update      |
    | edit feature | feature | story   | update      |
    | edit story   | story   | step    | update      |

  # @TODO Add another scenario to cover clicking through the paginator after a form is submitted

  Scenario Outline: Animated icon panels should still work
    Given there is a <item>
    And the <item> has more than 5 <assoc>
    When I am on the <page> page
    And I <form action> the <item> form
    And I submit the form
    Then there should be an AJAX request
    Then the item's panel should be visible

  Examples: A list of forms that enable the animation functionality when submitted
    | page         | item    | assoc   | form action |
    | edit project | project | feature | update      |
    | edit feature | feature | story   | update      |
    | edit story   | story   | step    | update      |

  Scenario Outline: The submitted form should be hidden
    Given there is a <item>
    When I am on the <page> page
    And I <form action> the <item> form
    When submit the form
    Then there should be an AJAX request
    And the form should be hidden

  Examples: A list of forms that when submitted should hide the submitted form
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
    When submit the form
    Then there should be an AJAX request
    And the form should be hidden
    And I should see "view form"

  Examples: A list of forms that should render view form button when submitted
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |

  # @TODO Add scenario for opening and closing the form view

  # @TODO Refactor so we can apply the same scenario to our edge case scenario's
  Scenario Outline: Displaying the sidebar after form submission
    Given there is a <item>
    When I am on the "<page>" page
    And I <form action> the <item> form
    Then the side bar should not be rendered
    When submit the form
    Then there should be an AJAX request
    And the sidebar will be rendered via AJAX

  Examples: All pages that should have render the sidebar after an AJAX based form submission
    | page            | item      | form action |
    | new project     | project   | fill in     |
    | new feature     | feature   | fill in     |
    | new story       | story     | fill in     |
    | new step        | step      | fill in     |
    | edit project    | project   | update      |
    | edit feature    | feature   | update      |
    | edit story      | story     | update      |
    | edit step       | step      | update      |