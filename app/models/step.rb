class Step < ActiveRecord::Base
  validates_uniqueness_of   :title
  validates_presence_of :title
  has_many :step_stories
  has_many :stories, :through => :step_stories
  
end