class FeatureStory < ActiveRecord::Base
  belongs_to :story
  belongs_to :feature
  acts_as_list :scope => :story_id
end