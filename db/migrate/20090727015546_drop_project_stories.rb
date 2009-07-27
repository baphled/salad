class DropProjectStories < ActiveRecord::Migration
  def self.up
    drop_table :project_stories
  end

  def self.down
  end
end
