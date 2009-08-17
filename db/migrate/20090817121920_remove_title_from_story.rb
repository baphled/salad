class RemoveTitleFromStory < ActiveRecord::Migration
  def self.up
    remove_column :stories, :title
  end

  def self.down
  end
end
