Given /^the "([^\"]*)" has ([^\"]*) "([^\"]*)"$/ do |model, amount, assoc|
  associated = []
  amount = amount.to_i
  case model
    when /project/
      amount.times { associated << assoc.capitalize.singularize.constantize.make }
      @project.features = associated
    when /feature/
      amount.times { associated << assoc.capitalize.singularize.constantize.make }
      @feature.stories = associated
    when /story/
      amount.times { associated << assoc.capitalize.singularize.constantize.make }
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


