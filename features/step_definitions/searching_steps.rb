When /^I search for steps contain '(.*)'$/ do |search|
  fill_in 'search_text', :with => "#{search}"
end

Then /^we should have a list of results$/ do
  response.should have_selector :ul do |search_list|
    search_list.should have_selector :li
  end
end

Then /^we click search$/ do
  click_button 'Search'
end

# @TODO Refactor so that we actually check that each result starts or contains Given
Then /^all results should contain 'Given'$/ do
  results = Step.find(:all, :conditions => ["title LIKE ?", "%Given%"])
  response.should contain "Results (#{results.size.to_s})"
end