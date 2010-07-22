Given /^the "([^\"]*)" has ([^\"]*) "([^\"]*)"$/ do |model, amount, assoc|
  associated = []
  amount = amount.to_i
  associate = assoc.capitalize.singularize.constantize
  amount.times { associated << associate.make } unless assoc.empty?
  case model
    when /project/
      @project.features = associated
    when /feature/
      @feature.stories = associated
    when /story/
      @story.steps = associated
    when //
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


