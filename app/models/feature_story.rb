class FeatureStory < ActiveRecord::Base
  belongs_to :story
  belongs_to :feature
end