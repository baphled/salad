class CreateFeaturesAsAField < ActiveRecord::Migration
  def self.up
    add_column :features, :as_a, :string
  end

  def self.down
    remove_column :features, :as_a
  end
end
