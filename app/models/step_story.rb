class StepStory < ActiveRecord::Base
  belongs_to :story
  belongs_to :step
end