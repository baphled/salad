class StepStory < ActiveRecord::Base
  belongs_to :story
  belongs_to :step
  acts_as_list :scope => :story_id
end