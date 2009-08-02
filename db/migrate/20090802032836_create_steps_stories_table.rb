class CreateStepsStoriesTable < ActiveRecord::Migration
  def self.up
    create_table :step_stories, :id => false do |t|
      t.column :story_id, :integer, :null => false
      t.column :step_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :step_stories
  end
end
