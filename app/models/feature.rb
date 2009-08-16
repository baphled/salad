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
    @_exported = feature_title
    self.stories.each do |story|
      @_exported += "#{feature_scenarios story}"
    end
    @_exported
  end
  
  def self.check_step step,last_step
    if !last_step.nil? && last_step.title.split(" ").first == step.title.split(" ").first
      return "    #{step.title.sub(step.title.split(" ").first, "And")}\n"
    else
      return "    #{step.title}\n"
    end
  end
  
  private
    def feature_scenarios story
      "  Scenario: #{story.title}\n#{story_titles story}" unless story.steps.blank?
    end
    
    def story_titles story
      check_steps story.steps
    end
    
    def feature_title
      @_head =     "Feature: #{title}\n  In order #{in_order}\n"
      @_head +=    "  As a #{as_a}\n  I want #{i_want}\n\n"
    end
    
    def check_steps steps
      @_titles = ""
      steps.each do |step|
        @_titles += Feature::check_step step,@_last_step
        @_last_step = step
      end
      @_titles
    end
end