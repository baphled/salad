Feature: When hovering over a panel link we want to display a speech bubble tooltip
  In order to improve the userability of the panel links
  As an user
  I want to be given functionality information when hovering over a panel link

  Scenario: When hovering over the feature's export link displays a tooltip
    Given there is a feature
    When I view the feature
    Then there should be a "export feature" link
    And I hover over the "export-feature" link
    Then a tooltip should be visible

  Scenario: When hovering over the feature's edit link displays a tooltip
    Given there is a feature
    When I view the feature
    Then there should be a "Edit" link
    And I hover over the "edit" link
    Then a tooltip should be visible

  Scenario: When hovering over the feature changes displays a tooltip
    Given we create a feature with a path
    When the feature is viewed
    Then there should be a "view changes" link
    And I hover over the "view-changes" link
    Then a tooltip should be visible

  Scenario: When hovering over the feature's merge changes link displays a tooltip
    Given we create a feature with a path
    And we edit the feature
    And we change the feature's title to "Something different"
    When I view the feature
    Then there should be a "merge changes" link
    And I hover over the "merge-changes" link
    Then a tooltip should be visible

  Scenario: When hovering over the feature's system sync link displays a tooltip
    Given we create a feature with a path
    And we edit the feature
    And we change the feature's title to "Something different"
    When I view the feature
    Then there should be a "system sync" link
    And I hover over the "system-sync" link
    Then a tooltip should be visible

  Scenario: When hovering over the feature's patch changes link displays a tooltip
    Given we create a feature with a path
    And we edit the feature
    And we change the feature's title to "Something different"
    When I view the feature
    Then there should be a "patch changes" link
    And I hover over the "patch-changes" link
    Then a tooltip should be visible