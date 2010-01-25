module ProjectsHelper
  def steps_imported? list
    list.each do |file|
      if Feature.find_by_title(file[:feature].title).nil?
        return false
  	  end
	  end
  end
end