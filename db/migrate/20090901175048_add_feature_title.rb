class AddFeatureTitle < ActiveRecord::Migration
  def self.up
    add_column :features, :title, :string, :limit => 300, :null => false
  end

  def self.down
    remove_column :features, :title
  end
end
