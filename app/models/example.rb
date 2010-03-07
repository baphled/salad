class Example < ActiveRecord::Base
  has_many :action_examples
  has_many :actions, :through => :action_examples

  has_many :example_stories
  has_many :stories, :through => :example_stories
end