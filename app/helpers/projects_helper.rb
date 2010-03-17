module ProjectsHelper
  def steps_imported? list
    list.each do |file|
      return (Feature.find_by_title(file[:feature].title).nil?)? false : nil
    end
  end

  def has_no_stories? feature
    (feature.stories.blank?)? true : false
  end

  def invalid_import? feature
    (feature.title.blank? || feature.in_order.blank? ||  feature.as_a.blank? || feature.i_want.blank?)? true : false
  end

  def has_duplicate_feature? feature_import, list
    found = []
    result = false
    list.each do |file|
      file[:feature].stories.each do |story|
        result = true if found.member?(story.scenario) and (file[:file] == feature_import)
        return result if result
        found << story.scenario
      end
      return result if result
    end
    result
  end
  
  def has_duplicate_feature_name? feature_path, list
    feature_titles = []
    list.each do |file|
      feature_titles << File.basename(file[:file])
    end
    if feature_titles.dups.empty? == false and feature_titles.dups.member?(File.basename(feature_path))
      return feature_path
    end
    false
  end
  
end