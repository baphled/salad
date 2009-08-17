class Step < ActiveRecord::Base
  validates_uniqueness_of   :title
  validates_presence_of :title
  validates_format_of :title, :with => /^(Given|When|Then).*$/, :message => "must start with Given"
  has_many :step_stories
  has_many :stories, :through => :step_stories
  
end