Feature: A user needs to be able to export created features into cucumber feature files
  In order to export features for use with cucumber, a feature needs to have stories with steps, not having these should end in an error.
  As a user
  I want to be able to export selected features from a project
	
	Scenario: A user should not be able to export a feature if a feature does not have any stories
	  Given we select a feature with no stories
	  When the feature with no stories is displayed
	  Then the the export link should not be viewable
	
	Scenario: A user tries to export a feature which has a story that have no steps
		Given we select a feature with stories
	  When a user attempts to export a feature
		And the feature has a story with no steps
		Then that story is not added to the exported feature
	  
	Scenario: When a user selects a feature, which has complete stories & steps, all its stories are exported to scenarios
	  Given there are features
	  When a user attempts to export a feature
		And the feature exists
		And the feature has stories
		And the stories have steps
		Then the feature should be converted to the necessary cucumber feature format