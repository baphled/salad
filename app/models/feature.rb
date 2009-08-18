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
      @_exported += "#{feature_scenarios story}\n"
    end
    @_exported
  end
  
  def self.format_step step,last_step
    if !last_step.nil? && last_step.first_word == step.first_word
      return "    #{step.convert_prefix}\n"
    else
      return "    #{step.title}\n"
    end
  end
  
  private
    def feature_scenarios story
      "  Scenario: #{story.scenario}\n#{story_titles story}" unless story.steps.blank?
    end
    
    def story_titles story
      @_titles = ""
      story.steps.each do |step|
        @_titles += Feature::format_step step, @_last_step
        @_last_step = step
      end
      @_titles
    end
    
    def feature_title
      @_head =     "Feature: #{title}\n  In order #{in_order}\n"
      @_head +=    "  As a #{as_a}\n  I want #{i_want}\n\n"
    end
end