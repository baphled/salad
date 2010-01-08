class Feature < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable
  
  validates_presence_of     :title
  validates_presence_of     :in_order
  validates_presence_of     :as_a
  validates_presence_of     :i_want
  
  validates_associated      :stories
  
  has_many :feature_projects
  has_many :projects, :through => :feature_projects
  
  has_many :feature_stories
  has_many :stories, :through => :feature_stories
  
  def export
    exported = feature_title
    self.stories.each do |story|
      exported += "#{feature_scenarios story}\n"
    end
    exported
  end
  
  def stories_attributes=(stories_attributes)
    stories_attributes.each do |attributes|
      stories.create({:scenario => attributes[:scenario].to_s.sub(/^Scenario: /,""),
                      :steps => build_steps(Story.formatted_steps attributes[:steps]) })
    end
  end
  
  private
    def build_steps steps
      new_steps = [] if new_steps.nil?
      steps.each do |step|
        if Step.find_by_title(step).nil?
          new_steps << Step.create(:title => step)
        else
          new_steps << Step.find_by_title(step)
        end
      end
      new_steps
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