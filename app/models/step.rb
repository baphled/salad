class Step < ActiveRecord::Base
  validates_uniqueness_of   :title, :if => :step_import?
  
  has_many :step_stories
  has_many :stories, :through => :step_stories
  
  def step_import?
    stories.each {|x| x.step_ids.nil?} == []
  end
end