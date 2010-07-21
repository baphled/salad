Given /^the "([^\"]*)" has 5 "([^\"]*)"$/ do |model, assoc|
  associated = []
  case model
    when /project/
      5.times { associated << assoc.capitalize.singularize.constantize.make }
      @project.features = associated
    when /feature/
      5.times { associated << assoc.capitalize.singularize.constantize.make }
      @feature.stories = associated
    when /story/
      5.times { associated << assoc.capitalize.singularize.constantize.make }
      @story.steps = associated
    when //
      # do nothing
    else
      raise "Can't instantiate \"#{model}\".\n" +
        "Now, go and add a mapping in #{__FILE__}"
  end
end

Then /^a flash message '(.*)' should be displayed$/ do |message|
  flash[:notice].should contain "#{message}"
end

When /^we click the "([^\"]*)" feature$/ do |link|
  click_link "#{link}"
end

When /^we submit the new feature$/ do
  click_button 'save'
end


