class CreateFeaturesInOrderField < ActiveRecord::Migration
  def self.up
    add_column :features, :in_order, :string
  end

  def self.down
    remove_column :features, :in_order
  end
end
