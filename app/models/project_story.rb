class ProjectStory < ActiveRecord::Base
  belongs_to :project
  belongs_to :story
end