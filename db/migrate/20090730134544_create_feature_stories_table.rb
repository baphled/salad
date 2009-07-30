class CreateFeatureStoriesTable < ActiveRecord::Migration
  def self.up
    create_table :feature_stories, :id => false do |t|
      t.column :story_id, :integer, :null => false
      t.column :feature_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :feature_stories
  end
end
