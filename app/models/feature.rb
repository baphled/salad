class Feature < ActiveRecord::Base
  validates_presence_of     :title
  validates_presence_of     :body
  
  has_many :feature_projects
  has_many :projects, :through => :feature_projects
  
  has_many :feature_stories
  has_many :stories, :through => :feature_stories
end