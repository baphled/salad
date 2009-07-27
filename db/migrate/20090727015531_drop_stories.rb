class DropStories < ActiveRecord::Migration
  def self.up
    drop_table :stories
  end

  def self.down
  end
end
