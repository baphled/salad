class FeaturePosition < ActiveRecord::Migration
  def self.up
    add_column :feature_projects, :position, :integer
  end

  def self.down
    remove_column :feature_projects, :position
  end
end
