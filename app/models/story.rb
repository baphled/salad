class Story < ActiveRecord::Base
  validates_presence_of     :title
  validates_presence_of     :scenario
  validates_uniqueness_of   :title
  
  has_many :feature_stories
  has_many :features, :through => :feature_stories
  
  has_many :step_stories
  has_many :steps, :through => :step_stories
end