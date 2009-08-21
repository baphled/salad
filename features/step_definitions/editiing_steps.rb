When /^we fill in the (.*) (.*) with '(.*)'$/ do |controller, attr, value|
  fill_in "#{controller}_#{attr}", :with => "#{value}"
end