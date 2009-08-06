class CreateFeaturesIWantField < ActiveRecord::Migration
  def self.up
    add_column :features, :i_want, :string
  end

  def self.down
    remove_column :features, :i_want
  end
end
