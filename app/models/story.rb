class Story < ActiveRecord::Base
	include MyActiveRecordExtensions
  acts_as_taggable
  
  validates_presence_of     :scenario
  validates_uniqueness_of   :scenario
  validates_length_of :scenario, :minimum => 7, :too_short => :too_short
  
  validates_associated      :steps, :on => :create
  
  has_many :feature_stories, :order => 'position'
  has_many :features, :through => :feature_stories
  
  has_many :step_stories
  has_many :steps, :through => :step_stories

  belongs_to :example
  
  accepts_nested_attributes_for :steps
  accepts_nested_attributes_for :example
  
  def self.formatted_steps steps
    last = nil
    results = []
    steps.each do |step|
			if step.include?("And")
				["Given", "When", "Then"].each do |prefix|        	
     			step = step.sub(/And /,"#{prefix} ") if last.include?(prefix)
       	end
			end
			results << step
			last = step unless step.include?("And")
		end
		results
  end
  
end