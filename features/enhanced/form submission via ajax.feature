Feature: Form submission via AJAX
  In order to keep the AJAX based form submission consistent
  As an user
  I want to experience the same kind of user journey regardless of using AJAX or not

  Scenario Outline: A feature we should still see the source feature file contents via a dialog box
    Given there is a <item>
    When I am on "<page>" page
    And "<form action>" the "<item>" form
    Then I submit the form
    Then there should be an AJAX request
    When I use the features path link
    Then there should be an AJAX request
    And a dialog box should appear

  Examples:
    | page          | item      | form action |
    | edit feature  | feature   | update      |

