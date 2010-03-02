class StepStory < ActiveRecord::Base
  belongs_to :story
  belongs_to :step
  acts_as_list :scope => :step_id
end