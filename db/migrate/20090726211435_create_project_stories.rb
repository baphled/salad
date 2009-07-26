class CreateProjectStories < ActiveRecord::Migration
  def self.up
    create_table :project_stories, :id => false do |t|
      t.column :project_id, :integer, :null => false
      t.column :story_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :project_stories
  end
end
