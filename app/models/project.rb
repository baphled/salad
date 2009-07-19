class Project < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
end