class FeatureProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :feature
  acts_as_list :scope => :project_id
end