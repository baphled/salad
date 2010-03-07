class ExampleStory < ActiveRecord::Base
  belongs_to :story
  belongs_to :example
end