# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'cucumber/rails/world'
require 'cucumber/rails/active_record'
require 'cucumber/web/tableish'

require 'webrat'
require 'webrat/core/matchers'

require 'cucumber/rails/rspec'
require 'spec/stubs/cucumber'
require 'spec/mocks/framework'
require 'spec/mocks/extensions'

require File.join(RAILS_ROOT, 'spec', 'blueprints')

#require 'cucumber/webrat/element_locator' # Deprecated in favor of #tableish - remove this line if you don't use #element_at or #table_at

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

# If you set this to false, any error raised from within your app will bubble 
# up to your step definition and out to cucumber unless you catch it somewhere
# on the way. You can make Rails rescue errors and render error pages on a
# per-scenario basis by tagging a scenario or feature with the @allow-rescue tag.
#
# If you set this to true, Rails will rescue all errors and render error
# pages, more or less in the same way your application would behave in the
# default production environment. It's not recommended to do this for all
# of your scenarios, as this makes it hard to discover errors in your application.
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
# require 'database_cleaner'
# DatabaseCleaner.strategy = :truncation

module FormHelpers
  def fill_form(form_name, opts = {})
    values = {}
    case form_name
      when /feature/
        values = {"title" => Sham.feature, "in_order" => 'to create the best app', "as_a" => 'user', "i_want" => 'the best project ever'}
      when /project/
        values = {"title" => Sham.title, "aim" => 'An aim', "description" => 'A description', "location" => "#{RAILS_ROOT}"}
      when /story/
        values = {"scenario" => Sham.scenario }
      when /step/
        values = {"title" => Sham.step }
      when /resource/
        values = {"name" => "baphled", "project" => "50164"}
      else
        raise "Can't find the form #{form_name}.\n" +
          "Now, go and add a mapping in #{__FILE__}"
    end

    parmas = values.merge(opts)
    parmas.each { |param, value| When %{we fill in the #{form_name} #{param} with '#{value}'} }
  end

  def fill_in_form_with_duplicate_data form_name
    model = form_name.capitalize.constantize.first
    opts = model.attributes
    ['id', 'created_at', 'updated_at', 'path'].each do |param|
      opts.delete param
    end
    fill_form form_name.singularize, opts
  end
end

World(Spec::Mocks::ExampleMethods, FormHelpers)

Before do
  $rspec_mocks ||= Spec::Mocks::Space.new
end

After do
  $rspec_mocks.reset_all
end