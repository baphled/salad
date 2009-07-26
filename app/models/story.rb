class Story < ActiveRecord::Base
  validates_presence_of     :title
  validates_presence_of     :body
  
  has_many :project_stories
  has_many :projects, :through => :project_stories
  
end