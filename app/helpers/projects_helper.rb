module ProjectsHelper
  def format_step step
    if step.include?("And")
  		if @last.include?("Given")
  			step.sub(/And /,"Given ")
  		elsif @last.include?("When")
  			step.sub(/And /,"When ")
  		else @last.include?("Then")
  			step.sub(/And /,"Then ")
  	  end
  	else
  		step
  	end    
  end
  
  def steps_imported? list
    list.each do |file|
      if Feature.find_by_title(file[:feature_title]).nil?
        returning false
  	  end
	  end
  end
end