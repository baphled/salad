Feature: A user needs to be able to export created features into cucumber feature files
  In order to export features for use with cucumber, a feature needs to have stories with steps, not having these should end in an error.
  As a user
  I want to be able to export selected features from a project
	
  Scenario: A user should not be able to export a feature if a feature does not have any stories
    Given we select a feature with no stories
	  When the feature with no stories is displayed
  	Then the export link should not be viewable
	
  Scenario: A user is able to export a feature that has stories with no steps
    Given we select a feature with stories
  	And the feature has a story with no steps
  	And the feature has other stories with steps
  	When we view the first feature
  	Then the export link should be viewable
	  
  Scenario: When a user selects a feature, which has complete stories & steps, all its stories are exported to scenarios
    Given we select a feature with stories
  	And the feature has a story with no steps
  	And the feature has other stories with steps
  	When we view the first feature
  	And a user attempts to export a feature
  	Then the feature should be converted to the necessary cucumber feature format
		
  Scenario: A user tries to export a feature which has a story that have no steps
  	Given we select a feature with stories
  	And the feature has a story with no steps
  	And the feature has other stories with steps
  	When we view the first feature
  	And the export link should be viewable
  	And a user attempts to export a feature
  	Then that story is not added to the exported feature

  Scenario: We want to be able to export the feature in a RESTful manner
    Given there is a feature
    When we view the feature with the "feature" format
    Then the feature should be displayed
    
  Scenario: Saving the exported feature
    Given there is a feature
    When I view the "export feature" path
    Then a "Download" button should be displayed
  
  
  