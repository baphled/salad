class Project < ActiveRecord::Base
  validates_presence_of     :title
  validates_presence_of     :description
  validates_presence_of     :aim
  validates_uniqueness_of   :title

  has_many :project_stories
  has_many :stories, :through => :project_stories
end