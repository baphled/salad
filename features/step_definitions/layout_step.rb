Then /^the view should not have a sidebar$/ do
  response.should_not have_selector :div, attribute = {:id => 'sidebar'}
end

Then /^the view "([^\"]*)" have a sidebar$/ do |matcher|
  if matcher == 'should'
    response.should have_selector :div, attribute = {:id => 'sidebar'}
  else matcher == 'should not'
    response.should_not have_selector :div, attribute = {:id => 'sidebar'}
  end
end

Then /^the order button should not be visible$/ do
  response.should_not have_selector :button, attribute = {:id => 'button', :role => 'button', :class => 'order_icon ui-state-default ui-priority-primary ui-corner-all'}
end