class AddUpdatedAtToFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :updated_at, :datetime
  end

  def self.down
    remove_column :features, :updated_at, :datetime
  end
  
end
