class FeatureProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :feature
  acts_as_list :scope => :feature_id
end