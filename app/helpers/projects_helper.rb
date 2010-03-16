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

  def has_duplicate_feature? features
    features.each do |file|
      found = []
      result = false
      file[:feature].stories.each do |story|
        result = true if found.include? story.scenario
        found << story.scenario
      end
      return result
    end
  end
end