class StoryHasOneExample < ActiveRecord::Migration
  def self.up
    add_column :stories, :example_id, :integer
  end

  def self.down
  end
end
