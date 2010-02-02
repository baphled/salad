Then /^a flash message '(.*)' should be displayed$/ do |message|
  flash.should contain "#{message}"
end

