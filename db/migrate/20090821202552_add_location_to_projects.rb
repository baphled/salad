class AddLocationToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :location, :string
  end

  def self.down
    remove_column :projects, :location
  end
end
