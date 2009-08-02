class FeatureStoryPosition < ActiveRecord::Migration
  def self.up
    add_column :feature_stories, :position, :integer
  end

  def self.down
    remove_column :feature_stories, :position
  end
end
