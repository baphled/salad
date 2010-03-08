Feature: To provide more information to the user we should display the most used item of a given controller
    In order to help the user know which items are most used
    As a user
    I want to be able to view the most used items easily

    Scenario Outline: Users viewing an index page which is not projects should display a most used section
      Given we have "<items>" that are "<state>" used
      When we visit the "<action>" index
      Then we get the most used items

    Examples: Our actions that we want to check states for
      |items    |action   |state      |
      |features |features |being      |
      |features |features |not being  |
      |stories  |stories  |being      |
      |stories  |stories  |not being  |
      |steps    |steps    |being      |
      |steps    |steps    |not being  |
      |features |stories  |being      |
      |features |stories  |not being  |
      |stories  |steps    |not being  |