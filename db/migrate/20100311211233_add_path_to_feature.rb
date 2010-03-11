class AddPathToFeature < ActiveRecord::Migration
  def self.up
    add_column :features, :path, :string, :limit => 250, :null => false
  end

  def self.down
    remove_column :features, :path
  end
end
