class Story < ActiveRecord::Base
  has_many :feature_stories
  has_many :features, :through => :feature_stories
end