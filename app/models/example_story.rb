class ExampleStory < ActiveRecord::Base
  belongs_to :stories
  belongs_to :examples
end