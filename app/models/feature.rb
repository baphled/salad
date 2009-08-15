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
      feature_scenarios story
    end
    @exported
  end
  
  private
    def feature_scenarios story
      if not story.steps.blank?
        @exported += "  Scenario: #{story.title}\n"
        @exported += story_titles story
      end
    end
    
    def story_titles story
      @_titles = ""
     story.steps.each do |step|
       if !@_last_step.nil? && @_last_step.title.split(" ").first == step.title.split(" ").first
         @_titles += "    #{step.title.sub(step.title.split(" ").first, "And")}\n"
       else
         @_titles += "    #{step.title}\n"
       end
       @_last_step = step
     end
     @_titles
    end
    
    def feature_title
      @_head =     "Feature: #{title}\n  In order #{in_order}\n"
      @_head +=    "  As a #{as_a}\n  I want #{i_want}\n\n"
    end
    
end