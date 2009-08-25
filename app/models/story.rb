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
				 if last.include?("Given")
				   results << step.sub(/And /,"Given ")
				 elsif last.include?("When")
					  results << step.sub(/And /,"When ")
				 else last.include?("Then")
					 results << step.sub(/And /,"Then ")
				 end
			 else
				results << step
			 end
			 last = step unless step.include?("And")
		 end
		results
  end
  
end