class StoryStepPosition < ActiveRecord::Migration
  def self.up
    add_column :step_stories, :position, :integer
  end

  def self.down
    remove_column :step_stories, :position
  end
end
