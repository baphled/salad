require 'webrat'

require 'spec/expectations'
require 'selenium'

Webrat.configure do |config|
  config.mode = :selenium
end

class ActiveSupport::TestCase
  setup do |session|
    session.host! "localhost:4444"
  end
end


ActionController::Base.allow_rescue = false

# If you set this to true, each scenario will run in a database transaction.
# You can still turn off transactions on a per-scenario basis, simply tagging
# a feature or scenario with the @no-txn tag. If you are using Capybara,
# tagging with @culerity or @javascript will also turn transactions off.
#
# If you set this to false, transactions will be off for all scenarios,
# regardless of whether you use @no-txn or not.
#
# Beware that turning transactions off will leave data in your database
# after each scenario, which can lead to hard-to-debug failures in
# subsequent scenarios. If you do this, we recommend you create a Before
# block that will explicitly put your database in a known state.
Cucumber::Rails::World.use_transactional_fixtures = true

# How to clean your database when transactions are turned off. See
# http://github.com/bmabey/database_cleaner for more info.
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

# this is necessary to have webrat "wait_for" the response body to be available
# when writing steps that match against the response body returned by selenium
World(Webrat::Selenium::Matchers)

# "before all"
browser = Selenium::SeleniumDriver.new("localhost", 4444, "*chrome", "http://localhost", 15000)

Before do
  @browser = browser
  @browser.start
end

After do
  @browser.stop
end
