class Example < ActiveRecord::Migration
  def self.up
    add_column :examples, :story_id, :integer
  end

  def self.down
    remove_column :examples, :story_id, :integer
  end
end
