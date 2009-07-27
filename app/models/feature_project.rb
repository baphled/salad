class FeatureProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :feature
end