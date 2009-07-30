class Story < ActiveRecord::Base
  has_many :feature_stories
  has_many :stories, :through => :feature_stories
end