class AddUpdatedAtToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :updated_at, :datetime
  end

  def self.down
    remove_column :projects, :updated_at, :datetime
  end
end
