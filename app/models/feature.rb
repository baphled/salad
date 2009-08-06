class Feature < ActiveRecord::Base
  acts_as_taggable
  
  validates_presence_of     :title
  
  has_many :feature_projects
  has_many :projects, :through => :feature_projects
  
  has_many :feature_stories
  has_many :stories, :through => :feature_stories
end