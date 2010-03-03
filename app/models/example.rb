class Example < ActiveRecord::Base
  has_many :action_examples
  has_many :actions, :through => :action_examples
end