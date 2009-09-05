class Story < ActiveRecord::Base
  acts_as_taggable
  
  validates_presence_of     :scenario
  validates_uniqueness_of   :scenario
  
  has_many :feature_stories
  has_many :features, :through => :feature_stories
  
  has_many :step_stories
  has_many :steps, :through => :step_stories
  
  def self.formatted_steps steps
    last = nil
    results = []
     steps.each do |step|
			 if step.include?("And")
				 ["Given", "When", "Then"].each do |prefix|
           if last.include?(prefix)
       			step.sub(/And /,"#{prefix} ")
         	else
         		step
         	end
       	end
			 else
				results << step
			 end
			 last = step unless step.include?("And")
		 end
		results
  end
  
end