class RemovedExampleStories < ActiveRecord::Migration
  def self.up
    drop_table :example_stories
  end

  def self.down
  end
end
