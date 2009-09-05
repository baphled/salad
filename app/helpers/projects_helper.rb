module ProjectsHelper
  def format_step step
    if step.include?("And")
      prefix_check
  	end
  end
  
  def prefix_check
    w%("Given, When, Then").each do |prefix|
      if @last.include?(prefix)
  			step.sub(/And /,"#{prefix} ")
    	else
    		step
    	end
  	end
  end
  
  def steps_imported? list
    list.each do |file|
      if Feature.find_by_title(file[:feature_title]).nil?
        return false
  	  end
	  end
  end
end