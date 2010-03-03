class Action < ActiveRecord::Base
  has_many :action_examples
  has_many :examples, :through => :action_examples
  
  has_many :action_items
  has_many :items, :through => :action_items
end