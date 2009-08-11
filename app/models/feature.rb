class Feature < ActiveRecord::Base
  acts_as_taggable
  
  validates_presence_of     :title
  validates_presence_of     :in_order
  validates_presence_of     :as_a
  validates_presence_of     :i_want
  
  has_many :feature_projects
  has_many :projects, :through => :feature_projects
  
  has_many :feature_stories
  has_many :stories, :through => :feature_stories
  
  def export
    @exported = feature_title
    self.stories.each do |story|
      if not story.steps.blank?
        @exported += "  Scenario: #{story.title}\n"
        story.steps.each do |step|
          @exported += "    #{step.title}\n"
        end
      end
    end
    @exported
  end
  
  private
    def feature_title
      @head =     "Feature: #{title}\n  In order #{in_order}\n"
      @head +=    "  As a #{as_a}\n  I want #{i_want}\n\n"
    end
    
end