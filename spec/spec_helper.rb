# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'
require File.join(RAILS_ROOT, 'spec', 'blueprints')
#require File.join(RAILS_ROOT, 'spec', 'matchers')
# Uncomment the next line to use webrat's matchers
require 'webrat/integrations/rspec-rails'

Spec::Matchers.define :have_features_to_import do
  match do |project|
    project.features_to_import?
  end

  failure_message_for_should do
    "expected the project to have features to import"
  end

  failure_message_for_should_not do
    "expected the project not to have any features to import"
  end

  description do
    "expected the project to have features to import"
  end
end

def content_for(name)
  response.template.instance_variable_get("@content_for_#{name}")
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.include Webrat::Matchers, :type => :views
  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

class UseLayout
  attr_reader :expected
  attr_reader :actual

  def initialize(expected)
    @expected = 'layouts/' + expected
  end

  def matches?(controller)
    if controller.is_a?(ActionController::Base)
      @actual = 'layouts/' + controller.class.read_inheritable_attribute(:layout)
    else
      @actual = controller.layout
    end
    @actual ||= "layouts/application"
    @actual == @expected
  end

  def description
    "Determines if a controller uses a layout"
  end

  def failure_message
    return "use_layout expected #{@expected.inspect}, got #{@actual.inspect}"
  end

 def negeative_failure_message
   return "use_layout expected #{@expected.inspect} not to equal #{@actual.inspect}"
  end
end

def use_layout(expected)
  UseLayout.new(expected)
end
