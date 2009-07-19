class RemoveNameFromProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :name
    add_column :projects, :title, :string
  end

  def self.down
    remove_column :projects, :title
  end
end
