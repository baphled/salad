class RemoveFeatureTitle < ActiveRecord::Migration
  def self.up
    remove_column :features, :title
  end

  def self.down
  end
end
