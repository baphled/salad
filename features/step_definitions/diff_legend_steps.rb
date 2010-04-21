Then /^changes on the "([^\"]*)" should be displayed as "([^\"]*)"$/ do |legend, class_name|
  legend_class = (class_name == "red")? "gd" : "gi"
  response.should have_selector :span, attribute = {:class => legend_class} do |content|
    content.should contain legend
  end
end

Then /^the following notice should be displayed "([^\"]*)"$/ do |notice|
  response.should have_selector :div, attribute = {:class => "notice"} do |wrapper|
    wrapper.should contain notice
  end
end