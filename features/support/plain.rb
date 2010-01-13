require 'cucumber/rails/rspec'

require 'spec/mocks/framework'
require 'spec/mocks/extensions'

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

World(Spec::Mocks::ExampleMethods)

Before do
  $rspec_stubs ||= Spec::Mocks::Space.new
end

After do
  $rspec_stubs.reset_all
end

ActionController::Base.allow_rescue = false
Cucumber::Rails::World.use_transactional_fixtures = true