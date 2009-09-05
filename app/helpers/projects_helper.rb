module ProjectsHelper
  def format_step step
    if step.include?("And")
      check_step_prefix
  	end
  end
  
  def check_step_prefix
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