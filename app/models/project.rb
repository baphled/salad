class Project < ActiveRecord::Base
  validates_presence_of :title
end