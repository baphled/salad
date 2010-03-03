class ActionItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :action
end