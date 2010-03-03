class Item < ActiveRecord::Base
  has_many :action_items
  has_many :actions, :through => :action_items
end