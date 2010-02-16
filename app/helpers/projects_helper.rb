module ProjectsHelper
  def steps_imported? list
    list.each do |file|
      if Feature.find_by_title(file[:feature].title).nil?
        return false
  	  end
	  end
  end

  def invalid_import? feature
    if feature.title.blank? || feature.in_order.blank? ||  feature.as_a.blank? || feature.i_want.blank? || feature.stories.blank?
      true
    else
      false
    end
  end
end