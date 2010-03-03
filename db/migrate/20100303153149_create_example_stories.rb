class CreateExampleStories < ActiveRecord::Migration
  def self.up
    create_table :example_stories, :id => false do |t|
      t.column :story_id, :integer, :null => false
      t.column :example_id, :integer, :null => false
    end
  end

  def self.down
    drop_table "example_stories"
  end
end
