class RemoveFeaturesBodyField < ActiveRecord::Migration
  def self.up
    remove_column :features, :body
  end

  def self.down
  end
end
