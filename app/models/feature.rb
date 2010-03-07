class Feature < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable

  validates_uniqueness_of   :title
  
  validates_presence_of     :title
  validates_presence_of     :in_order
  validates_presence_of     :as_a
  validates_presence_of     :i_want
  
  validates_associated      :stories

  validates_length_of :title, :minimum => 6, :too_short => @@error_message
  validates_length_of :in_order, :minimum => 7, :too_short => @@error_message
  validates_length_of :as_a, :minimum => 4, :too_short => @@error_message
  validates_length_of :i_want, :minimum => 7, :too_short => @@error_message
  
  validate :is_unique?
  
  has_many :feature_projects, :order => 'position'
  has_many :projects, :through => :feature_projects
  
  has_many :feature_stories, :order => 'position'
  has_many :stories, :through => :feature_stories

  accepts_nested_attributes_for :stories
  
  def export
    exported = feature_title
    self.stories.each do |story|
      exported += "#{feature_scenarios story}\n"
    end
    exported
  end
  
  private
    def is_unique?
      Feature.find_by_title self.title == nil
    end
    
    def feature_scenarios story
      "  Scenario: #{story.scenario}\n#{story_titles story}" unless story.steps.blank?
    end
    
    def story_titles story
      titles = ""
			last_step = nil
      story.steps.each do |step|
        titles += step.formatted last_step
        last_step = step
      end
      titles
    end
    
    def feature_title
      head =     "Feature: #{title}\n  In order #{in_order}\n"
      head +=    "  As a #{as_a}\n  I want #{i_want}\n\n"
    end
end