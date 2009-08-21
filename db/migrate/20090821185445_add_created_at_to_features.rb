class AddCreatedAtToFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :created_at, :datetime
  end

  def self.down
    remove_column :features, :created_at
  end
end
