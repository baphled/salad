class AddCreatedAtToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :created_at, :datetime
  end

  def self.down
    remove_column :projects, :created_at
  end
end
