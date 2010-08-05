Feature: Changes view improvements
  In order help me know what has changed
  As a user
  I want to be given more information

  Scenario Outline: Each sync and change view should have a legend of what has change
    Given there is a feature
    When the feature has changed "Something different"
    And I am on "a feature"
    And I use the "<link>" link
    Then changes on the "<system_or_file>" should be displayed as "<colour>"

  Examples: Legend views
    | link          | system_or_file        | colour |
    | merge-changes | Removing from file    | red    |
    | merge-changes | Adding to file        | green  |
    | merge-system  | Adding to system      | green  |
    | merge-system  | Removing from system  | red    |
    | view-changes  | Changes to the file   | green  |
    | view-changes  | Changes to the system | red    |

  Scenario Outline: There should be a notice warning users a feature file will be changed when patching a feature file
    Given there is a feature
    When the feature has changed "Something different"
    And I am on "a feature"
    And I use the "<link>" link
    Then the following notice should be displayed "<notice>"

  Examples: Changes notices
    | link          | notice                                                                                    |
    | merge-changes | This will change the source file. Unless you use source control, you may lose all changes |
    | merge-system  | This change will update the system feature                                                |
